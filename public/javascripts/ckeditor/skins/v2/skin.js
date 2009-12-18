/*
Copyright (c) 2003-2009, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.skins.add('v2',(function(){var a=[];if(CKEDITOR.env.ie&&CKEDITOR.env.version<7)a.push('icons.png','images/sprites_ie6.png','images/dialog_sides.gif');return{preload:a,editor:{css:['editor.css']},dialog:{css:['dialog.css']},templates:{css:['templates.css']},margins:[0,14,18,14]};})());if(CKEDITOR.dialog)CKEDITOR.dialog.on('resize',function(a){var b=a.data,c=b.width,d=b.height,e=b.dialog,f=e.parts.contents;if(b.skin!='v2')return;f.setStyles({width:c+'px',height:d+'px'});if(!CKEDITOR.env.ie)return;setTimeout(function(){var g=e.parts.dialog.getChild([0,0,0]),h=g.getChild(0),i=g.getChild(2);i.setStyle('width',h.$.offsetWidth+'px');i=g.getChild(7);i.setStyle('width',h.$.offsetWidth-28+'px');i=g.getChild(4);i.setStyle('height',h.$.offsetHeight-31-14+'px');i=g.getChild(5);i.setStyle('height',h.$.offsetHeight-31-14+'px');},100);});
