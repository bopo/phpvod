<?php
class CjAction extends BaseAction
{
	// 展示列表
	public function show()
	{
		$list = D('Cj')->order('cj_id asc')->select();
	
		$this->assign('list_cj',$list);
		$this->assign('jumpurl',F('_cj/xucai'));
		$this->display('./Public/system/cj_list.html');
	}
	
	// 添加编辑采集节点
  	public function add()
  	{
		$id = intval($_GET['id']);
	  	$rs = D("Cj");
		
		if ($id) 
		{
      		$where['cj_id'] = $id;
			$list = $rs->where($where)->find();
		}

		$this->assign($list);
		$this->display('./Public/system/cj_add.html');
  	}
	
	// 添加采集节点
	public function insert() 
	{
		$rs = D("Cj");
	
		if ($rs->create()) 
		{
			if (false !==  $rs->add()) 
			{
				redirect('?s=Admin-Cj-Show');
			}
			else
			{
				$this->error($rs->getError().'添加资源库地址失败！');
			}
		}
		else
		{
		    $this->error($rs->getError());
		}	
	}

	// 更新采集节点
	public function update()
	{
		$rs = D("Cj");
		
		if ($rs->create()) 
		{
			$list = $rs->save();
			
			if ($list !== false) 
			{
			    redirect('?s=Admin-Cj-Show');
			}
			else
			{
				$this->error("更新资源库地址失败！");
			}
		}
		else
		{
			$this->error($rs->getError());
		}
	}

	// 删除采集节点
	public function del()
	{
		$where['cj_id'] = $_GET['id'];
		D("Cj")->where($where)->delete();
		redirect('?s=Admin-Cj-Show');
	}
	
	// 检测第三方资源分类是否绑定
	public function setbind()
	{
		$rs = M("List");
		$list = $rs->field('list_id,list_pid,list_sid,list_name')
			->where('list_sid = 1')->order('list_id asc')->select();
		
		foreach($list as $key=>$value)
		{
			if(!ff_list_isson($list[$key]['list_id']))
			{
				unset($list[$key]);
			}
		}

		$array_bind = F('_cj/bind');

		$this->assign('vod_cid',$array_bind[$_GET['bind']]);//绑定后的系统分类
		$this->assign('vod_list',$list);
		$this->display('./Public/system/cj_setbind.html');
	}

	// 存储第三方资源分类绑定
  	public function insertbind()
  	{
		$bindcache = F('_cj/bind');
	
		if (!is_array($bindcache)) 
		{
			$bindcache = array();
			$bindcache['1_1'] = 0;
		}
		
		$bindkey = trim($_GET['bind']);
		$bindinsert[$bindkey] = intval($_GET['cid']);
		$bindarray = array_merge($bindcache,$bindinsert);
		
		F('_cj/bind',$bindarray);
		exit('ok');
	}

	// 资源站定时采集
	public function win()
	{
		$list = D('Cj')->order('cj_id asc')->select();
	
		$this->assign('list_cj',$list);
		$this->display('./Public/system/cj_time_win.html');
	}
	
	// 执行定时采集任务
	public function wait()
	{
		$infos = D("List")->field('list_id')->where('list_sid=1')->order('list_id asc')->select();
	
		foreach($infos as $key=>$value)
		{
			$list[$key] = $value['list_id'];
		}
		
		$this->assign('list_vod_all',implode(',',$list));

		$array = $_REQUEST['ds'];
		$array['min'] = $array['caiji']+$array['create'];

		$this->assign($array);
		$this->display('./Public/system/cj_time_wait.html');
	}

	// 自定义采集参数
	public function apimy()
	{
		$url = '?s=Admin-Cj-Api-action-all-xmlurl-'.$_POST['xmlurl'].'-cjid-'.$_POST['cjid'].'-cid-'.$_POST['cid'].'-h-'.$_POST['h'].'-play-'.$_POST['play'].'-field-'.$_POST['field'].'-limit-'.$_POST['limit'];

		redirect($url);
	}

	// 采集资源站
	public function api()
	{
		$array_url = array(); //本地程序跳转参数
		//获取跳转参数
		$array_url['action'] = $_GET['action']; //是否入库(all/day/ids/week/show)
		$array_url['xmlurl'] = base64_decode($_GET['xmlurl']); //资源库网址
		$array_url['cjid'] = intval($_GET['cjid']); //资源库ID
		//
		$array_url['cid'] = $_GET['cid']; //指定视频分类
		$array_url['h'] = intval($_GET['h']); //指定时间
		$array_url['inputer'] = $_GET['inputer']; //指定资源库频道
		$array_url['play'] = $_GET['play']; //指定播放器组(如不指定则为目标站的全部播放器组)
		$array_url['vodids'] = $_GET['vodids']; if($_POST['ids']){$array_url['vodids'] = implode(',',$_POST['ids']);}//指定视频ID
		$array_url['wd'] = $_GET['wd']; if($_POST['wd']){$array_url['wd'] = trim($_POST['wd']);} //指定关键字
		//
		$array_url['field'] = $_GET['field']; //重采资料字段
		$array_url['limit'] = $_GET['limit']; //每页采集的数量
		$array_url['p'] = !empty($_GET['p'])?intval($_GET['p']):1;//分页	
		// 调用抓取数据处理函数
		$json_data = $this->get_api_data($array_url);
		
		// 是否采集入库
		if( in_array($array_url['action'], array('ids','day','all','week')) )
		{
			$this->database($array_url, $json_data);
			//分页采集并记录最后采集网址
			if( in_array($array_url['action'],array('day','week','all')) )
			{
				$page = $array_url['p'];
				$page_max = $json_data['page']['pagecount'];
				$array_url['p'] = 'FFLINK';
				$array_url['xmlurl'] = base64_encode($array_url['xmlurl']);
				$page_link = U('Admin-Cj/api', $array_url);
				$this->jump($page, $page_max, $page_link);
			}
		}
		else
		{
			//列表分页的方式展示抓取的数据列表
			$array_url['vodids'] = '';
		
			$this->assign($array_url);
			$this->assign('cj_page', $json_data['page']);
			$this->assign('cj_list', $json_data['list']);
			$this->assign('cj_data', $json_data['data']);
		
			// 生成模板分页跳转信息
			$array_url['p'] = 'FFLINK';
			$array_url['xmlurl'] = base64_encode($array_url['xmlurl']);
			$page_link = U('Admin-Cj/api', $array_url);
			$page_list = '共'.$json_data['page']['recordcount'].'条数据&nbsp;页次:'.$json_data['page']['pageindex'].'/'.$json_data['page']['pagecount'].'页&nbsp;'.getpage($json_data['page']['pageindex'],$json_data['page']['pagecount'], 5, $page_link, 'pagego(\''.$page_link.'\','.$json_data['page']['pagecount'].')');
		
			$this->assign('page_list', $page_list);
			$this->display('./Public/system/cj_show.html');
		}
	}

	// 抓取数据(统一接口)
	public function get_api_data($array_url)
	{
		//组合资源库URL地址并获取XML资源
		$http_url =$array_url['xmlurl'].'index.php?s=plus-api-json-action-'.$array_url['action'].'-cid-'.$array_url['cid'].'-h-'.$array_url['h'].'-play-'.$array_url['play'].'-inputer-'.$array_url['inputer'].'-vodids-'.$array_url['vodids'].'-wd-'.urlencode($array_url['wd']).'-p-'.$array_url['p'].'-limit-'.$array_url['limit'];
		$json = ff_file_get_contents($http_url);//{status page list data}
	
		// 资源库状态判断
		if ($json) 
		{
			$json = json_decode($json, true);
		
			if($json['status'] == 501)
			{
				$this->error("连接API资源库成功，但服务器IP未获得授权。");
			}

			if(!$json['list'])
			{
				$this->error("连接APi资源库成功、但采集到的数据格式不正确。");
			}
		}
		else
		{
			$this->error("连接API资源库失败、通常为服务器网络不稳定或禁用了采集。");
		}
		
		// 获取到的远程栏目数据增加对应的绑定ID
		foreach($json['list'] as $key=>$value)
		{
			$json['list'][$key]['bind_id'] = $array_url['cjid'].'_'.$json['list'][$key]['list_id'];
		}

		// 获取到的远程视频列表数据格式化处理
		foreach($json['data'] as $key=>$value)
		{
			$json['data'][$key]['vod_cid'] = intval(ff_bind_id($array_url['cjid'].'_'.$value['vod_cid']));
		
			if( isset($json['data'][$key]['vod_scenario']) )
			{
				$json['data'][$key]['vod_scenario'] = json_encode($json['data'][$key]['vod_scenario']);
			}
			
			if(!$json['data'][$key]['vod_reurl'])
			{
				$json['data'][$key]['vod_reurl'] = base64_decode($array_url['xmlurl']).$json['data'][$key]['vod_id'];
			}
		}

		return $json;
	}

	// 分页采集入库
	private function database($array_url, $json_data)
	{
		echo'<style type="text/css">li{font-size:12px;color:#333;line-height:21px}span{font-weight:bold;color:#FF0000}</style>';
		echo'<div id="show"><li>共有<span>'.$json_data['page']['recordcount'].'</span>个数据，需要采集<span>'.$json_data['page']['pagecount'].'</span>次，正在执行第<span color=green>'.$array_url['p'].'</span>次采集任务，每一次采集<span>'.$json_data['page']['pagesize'].'</span>个。</li>';
	
		// 重采资料或是采集入库
		if($array_url['field'] && $json_data['data'])
		{
			$field = explode(',',$array_url['field']);
		
			foreach($json_data['data'] as $key=>$vod)
			{
				$data = array();
			
				foreach($field as $keyfield=>$value)
				{
					$data[$value] = $vod[$value];
				}
				
				$status = D('VodXml')->xml_field($data, $vod['vod_reurl']);
				
				if($status)
				{
					echo '<li>重采['.ff_list_find($vod['vod_cid']).'] '.$vod['vod_name'].' '.$array_url['field'].'更新完成。</li>';
				}
				else
				{
					echo '<li>重采['.ff_list_find($vod['vod_cid']).'] '.$vod['vod_name'].' 没有添加该片或不需要更新。</li>';
				}
				
				ob_flush();
				flush();
			}
		}
		else
		{
			foreach($json_data['data'] as $key=>$vod)
			{
				$array_vod_play = explode('$$$',$vod['vod_play']);
				$array_vod_url = explode('$$$',$vod['vod_url']);
			
				echo '<li>第<span>'.(($array_url['p']-1)*$json_data['page']['pagesize']+$key+1).'</span>个影片有<span>'.count($array_vod_play).'</span>组播放地址 ['.ff_list_find($vod['vod_cid']).'] '.$vod['vod_name'].' <font color="green">';
				
				//有几组播放地址就添加几次
				foreach($array_vod_play as $ii=>$value)
				{
					$vod['vod_inputer'] = 'xml_'.$array_url['cjid'];
					$vod['vod_play'] = $value;
					$vod['vod_url'] = trim($array_vod_url[$ii]);
					echo D('VodXml')->xml_insert($vod);
				}
				
				echo '</font></li>';
				ob_flush();
				flush();
			}
		}

		echo '</div>';
	}

	// 分页采集跳转
	private function jump($page, $pagemax, $pagelink)
	{
		if($page < $pagemax)
		{
			//缓存断点续采并跳转到下一页
			$jumpurl = str_replace('FFLINK',($page+1), $pagelink);
			F('_cj/xucai',$jumpurl);

			echo C('collect_time').'秒后将自动采集下一页!';
			echo '<meta http-equiv="refresh" content='.C('collect_time').';url='.$jumpurl.'>';
		}
		else
		{
			//清除断点续采
			F('_cj/xucai',NULL);
			
			echo '<div>恭喜您，所有采集任务已经完成，返回[<a href="?s=Admin-Vod-Show">视频管理中心</a>]，查看[<a href="?s=Admin-Vod-Show-vod_cid-0">需要人工再次审核的数据</a>]!</div>';
		}
	}		
}
