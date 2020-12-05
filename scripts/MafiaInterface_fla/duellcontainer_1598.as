package MafiaInterface_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class duellcontainer_1598 extends MovieClip
   {
       
      
      public var fighter1_left:MovieClip;
      
      public var fighter2_freecard:MovieClip;
      
      public var fighter2_left:MovieClip;
      
      public var fighter1_freecard:MovieClip;
      
      public var txt_fighter1:TextField;
      
      public var fighter1_unknown:MovieClip;
      
      public var txt_fighter2:TextField;
      
      public var fighter2_unknown:MovieClip;
      
      public var fighter1_lost:MovieClip;
      
      public var btn_view:Btn_ViewFight;
      
      public var fighter2_lost:MovieClip;
      
      public var fighter_1_avatar:emptyMC;
      
      public var fighter_2_avatar:emptyMC;
      
      public function duellcontainer_1598()
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
