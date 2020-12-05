package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class AddFriends extends MovieClip
   {
       
      
      public var txt_email:TextField;
      
      public var btn_close:NewCloseButton;
      
      public var steptwo:MovieClip;
      
      public var btn_no:NewBasicLeftGrowButtonTransparent;
      
      public var bg:MovieClip;
      
      public var txt_name:TextField;
      
      public var txt_title:TextField;
      
      public var txt_friendsbonuscount:TextField;
      
      public var txt_friendsbonus:TextField;
      
      public var txt_nameFriend:TextField;
      
      public var txt_copy:TextField;
      
      public var txt_friendsbonustitle:TextField;
      
      public var stepone:MovieClip;
      
      public var stepthree:MovieClip;
      
      public var btn_yes:NewBasicRightGrowButtonGreen;
      
      public function AddFriends()
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
