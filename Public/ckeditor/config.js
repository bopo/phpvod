CKEDITOR.editorConfig = function( config ) {
	config.language = 'zh-cn';
	config.width = '99%';
  config.height = 400;
	config.toolbar = 'Basic';
	config.toolbar_Basic =[
		['Source', 'FontSize', 'Bold', 'Italic', 'TextColor', 'BGColor', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink', 'Anchor', '-'],
		['PasteText', 'ImageButton', 'ShowBlocks', '-', 'PageBreak']
	];	
	//config.enterMode = CKEDITOR.ENTER_BR;
	//config.shiftEnterMode = CKEDITOR.ENTER_P;
};
