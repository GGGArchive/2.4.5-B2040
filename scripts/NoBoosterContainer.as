package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class NoBoosterContainer extends MovieClip
   {
       
      
      public var btn_toBoosterShop:Btn_NoBooster;
      
      public var txt_noBooster:TextField;
      
      public function NoBoosterContainer()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.txt_noBooster.mouseEnabled = false;
      }
   }
}
