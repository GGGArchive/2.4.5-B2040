package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Currency2PlusAni_193 extends MovieClip
   {
       
      
      public function Currency2PlusAni_193()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,24,this.frame25);
      }
      
      function frame1() : *
      {
         this.visible = false;
      }
      
      function frame2() : *
      {
         this.visible = true;
      }
      
      function frame25() : *
      {
         gotoAndStop(1);
      }
   }
}
