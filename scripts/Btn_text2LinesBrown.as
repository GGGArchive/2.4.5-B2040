package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class Btn_text2LinesBrown extends MovieClip
   {
       
      
      public var txt_label:TextField;
      
      public function Btn_text2LinesBrown()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         mouseChildren = false;
      }
   }
}
