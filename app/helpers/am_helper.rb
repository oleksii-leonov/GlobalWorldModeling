module AmHelper
  def render_timelinemap(root_path, callback_uri, width, height, bg_color, map_no)
    "<script type=\"text/javascript\" src=\"#{root_path}/swfobject.js\"></script>
   	<div id=\"maptimeline"+ map_no +"\">
   		<strong>You need to upgrade your Flash Player</strong>
   	</div>
    <script type='text/javascript'>
    // <![CDATA[
    var so = new SWFObject(\"#{root_path}/amtimeline.swf\", \"amtimeline\", \"#{width}\", \"#{height}\", \"8\", \"#{bg_color}\");
  	so.addVariable(\"data_file\", encodeURIComponent(\"#{callback_uri}\"));	
  	so.addVariable(\"path\", \"#{root_path}/\");
  	so.write(\"maptimeline"+ map_no +"\");  
    // ]]>
    </script>"
  end
  
  def render_ammap(root_path, callback_uri, width, height, bg_color, map_no)
    "<script type=\"text/javascript\" src=\"#{root_path}/swfobject.js\"></script>
   	<div id=\"map"+ map_no +"\">
   		<strong>You need to upgrade your Flash Player</strong>
   	</div>
    <script type='text/javascript'>
    // <![CDATA[
    var so = new SWFObject(\"#{root_path}/ammap.swf\", \"ammap\", \"#{width}\", \"#{height}\", \"8\", \"#{bg_color}\");
  	so.addVariable(\"data_file\", encodeURIComponent(\"#{callback_uri}\"));
  		so.addVariable(\"settings_file\", encodeURIComponent(\"/ammap/ammap_settings.xml?#{rand(100)}\"));
  	so.addVariable(\"path\", \"#{root_path}/\");
  	so.write(\"map"+ map_no +"\");  
    // ]]>
    </script>"
  end
  
  def render_ammap_countries_and_values(root_path, callback_uri, width, height, bg_color, map_no)
    "<script type=\"text/javascript\" src=\"#{root_path}/swfobject.js\"></script>
   	<div id=\"map"+ map_no +"\">
   		<strong>You need to upgrade your Flash Player</strong>
   	</div>
    <script type='text/javascript'>
    // <![CDATA[
    var so = new SWFObject(\"#{root_path}/ammap.swf\", \"ammap\", \"#{width}\", \"#{height}\", \"8\", \"#{bg_color}\");
  	so.addVariable(\"data_file\", encodeURIComponent(\"#{callback_uri}\"));
  		so.addVariable(\"settings_file\", encodeURIComponent(\"/ammap/ammap_settings_cv.xml?#{rand(100)}\"));
  	so.addVariable(\"path\", \"#{root_path}/\");
  	so.write(\"map"+ map_no +"\");  
    // ]]>
    </script>"
  end
  
  def render_amline(root_path, callback_uri, settings_uri, width, height, bg_color, chart_no)
    "<script type=\"text/javascript\" src=\"#{root_path}/swfobject.js\"></script>
   	<div id=\"chart"+ chart_no +"\">
   		<strong>You need to upgrade your Flash Player</strong>
   	</div>
    <script type='text/javascript'>
    // <![CDATA[
    var so = new SWFObject(\"#{root_path}/amline.swf\", \"amline\", \"#{width}\", \"#{height}\", \"8\", \"#{bg_color}\");
  	so.addVariable(\"settings_file\", encodeURIComponent(\"#{settings_uri}\"));
  	so.addVariable(\"data_file\", encodeURIComponent(\"#{callback_uri}\"));
  	so.addVariable(\"path\", \"#{root_path}/\");
  	so.write(\"chart"+ chart_no +"\");  
    // ]]>
    </script>"
  end

end
