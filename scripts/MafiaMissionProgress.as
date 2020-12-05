package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MafiaMissionProgress extends MovieClip
   {
       
      
      public var txt_value:TextField;
      
      public var btn_cancel:NewBasicRightGrowButtonBlue;
      
      public var clock:Clock;
      
      public var missionGiverHolder:emptyMC;
      
      public var bg:MovieClip;
      
      public var txt_title:TextField;
      
      public var btn_quit:NewBasicRightGrowButtonGreen;
      
      public var progress_Bar:MissionProgress_Bar;
      
      public var txt_copy:TextField;
      
      public function MafiaMissionProgress()
      {
         super();
      }
   }
}
