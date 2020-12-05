package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaMailVerification extends MovieClip
   {
       
      
      public var btn_close:NewCloseButton;
      
      public var txt_email:TextField;
      
      public var btn_ok:MafiaBasicButtonBlue;
      
      public var txt_copy2:TextField;
      
      public var bg:MovieClip;
      
      public var txt_title:TextField;
      
      public var txt_copy:TextField;
      
      public function MafiaMailVerification()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.bg.gotoAndStop(2);
      }
   }
}
