private void Page_Load(object sender, System.EventArgs e)
{
// Create a CAPTCHA image using the querystring "code"
string theText=Request.QueryString["code"].ToString();
string newText=String.Empty;

int y=0;
for(int i=0;i<theText.Length;i++){
y = Int32.Parse(theText.Substring(i,1)) +1; 
newText+= y.ToString(); 
}
CaptchaImage ci = new CaptchaImage(newText, 200, 50, "Arial"); 
this.Response.Clear();
this.Response.ContentType = "image/jpeg";

// Write the image to the response stream in JPEG format.
ci.Image.Save(this.Response.OutputStream, ImageFormat.Jpeg);

// cleanup 
ci.Dispose();
}
