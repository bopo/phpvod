<?php
class AjaxAction extends HomeAction
{
	public function _empty($action) 
	{
		$this->_empty_cm($action); 
	} 
	
	protected function _empty_cm($action)
	{
		$this->display('Home:ajax_'.$action); 
	}
}