/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.skins.add('office2003',(function(){var a=[];if(CKEDITOR.env.ie&&CKEDITOR.env.version<7)a.push('icons.png','images/sprites_ie6.png','images/dialog_sides.gif');return{preload:a,editor:{css:['editor.css']},dialog:{css:['dialog.css']},templates:{css:['templates.css']},margins:[0,14,18,14]};})());if(CKEDITOR.dialog)CKEDITOR.dialog.on('resize',function(a){var b=a.data,c=b.width,d=b.height,e=b.dialog,f=e.parts.contents;if(b.skin!='office2003')return;f.setStyles({width:c+'px',height:d+'px'});if(!CKEDITOR.env.ie)return;var g=function(){var h=e.parts.dialog.getChild([0,0,0]),i=h.getChild(0),j=h.getChild(2);j.setStyle('width',i.$.offsetWidth+'px');j=h.getChild(7);j.setStyle('width',i.$.offsetWidth-28+'px');j=h.getChild(4);j.setStyle('height',i.$.offsetHeight-31-14+'px');j=h.getChild(5);j.setStyle('height',i.$.offsetHeight-31-14+'px');};setTimeout(g,100);if(a.editor.lang.dir=='rtl')setTimeout(g,1000);});
