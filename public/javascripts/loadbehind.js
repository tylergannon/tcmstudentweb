$(function () {
  $('[data-submit]').click(function() {
    $('#'+$(this).attr('data-submit')).submit();
    return false;
  });

  $.growl.settings.dockCss.width = '225px';
  $.growl.settings.noticeTemplate = ''
	+ '<table width="225" border="0" cellpadding="0" cellspacing="0">'
	+ '	<tr>'
	+ '		<td style="background-image: url(images/growl/growl_top.png); width: 225px; height: 49px; background-repeat: no-repeat; color: #fff;">'
	+ '			<img src="%image%" style="max-width: 25px; max-height: 25px; text-align: center; margin-left: 19px; margin-top: 19px;" />'
	+ '			<h1 style="font-size: 18px; margin: 0pt; margin-left: 5px; margin-bottom: 10px; display: inline;">%title%</h1>'
	+ '		</td>'
	+ '	</tr>'
	+ '	<tr>'
	+ '		<td style="background-image: url(images/growl/growl_repeat.png); width: 225px; background-repeat: repeat-y; color: #ddd;">'
	+ '			<p style="margin: 20px;">%message%</p>'
	+ '		</td>'
	+ '	</tr>'
	+ '	<tr>'
	+ '	<td style="background-image: url(images/growl/growl_bottom.png); background-repeat: no-repeat; width: 225px; height: 27px;" valign="top" align="right" >'
	+ '			<a style="margin-right: 25px; font-size: 10px; color: #fff; text-align: right;" href="" onclick="return false;" rel="close">Close</a>'
	+ '		</td>'
	+ '	</tr>'
	'+ </table>';
  $.growl.settings.noticeCss = {
    position: 'relative'
  };


});

