package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class duellcontainer_1588 extends MovieClip
   {
       
      
      public var fighter1_left:MovieClip;
      
      public var fighter2_freecard:MovieClip;
      
      public var fighter2_left:MovieClip;
      
      public var fighter1_freecard:MovieClip;
      
      public var fighter1_unknown:MovieClip;
      
      public var fighter2_unknown:MovieClip;
      
      public var fighter1_lost:MovieClip;
      
      public var btn_view:Btn_ViewFight;
      
      public var fighter2_lost:MovieClip;
      
      public var fighter_1_avatar:emptyMC;
      
      public var fighter_2_avatar:emptyMC;
      
      public function duellcontainer_1588()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
