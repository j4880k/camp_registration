# Be sure to restart your server when you modify this file.

#workaround to Multiple vulnerabilities in parameter parsing in Action Pack (CVE-2013-0156) 
#Not using xml so killing the parser until fixed
ActionDispatch::ParamsParser::DEFAULT_PARSERS.delete(Mime::XML) 