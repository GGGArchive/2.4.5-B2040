package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class PicWork_955 extends MovieClip
   {
       
      
      public var npc_hk:MovieClip;
      
      public function PicWork_955()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         this.npc_hk.gotoAndStop(2);
      }
   }
}
