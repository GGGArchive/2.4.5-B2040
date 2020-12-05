package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaMailGiftReminder extends MovieClip
   {
       
      
      public var btn_close:NewCloseButton;
      
      public var btn_later:NewBasicLeftGrowButtonTransparent;
      
      public var bg:MovieClip;
      
      public var txt_title:TextField;
      
      public var txt_copy:TextField;
      
      public var btn_yes:NewBasicRightGrowButtonGreen;
      
      public function MafiaMailGiftReminder()
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
