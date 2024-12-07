import cherrypy

class HelloWorld():
    @cherrypy.expose
    def index(self):
        return "Hello World"
    
cherrypy.quickstart(HelloWorld())