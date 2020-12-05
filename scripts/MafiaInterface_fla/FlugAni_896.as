package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class FlugAni_896 extends MovieClip
   {
       
      
      public var oval_mask:MovieClip;
      
      public var flower_maskee:MovieClip;
      
      public function FlugAni_896()
      {
         super();
         addFrameScript(8,this.frame9);
      }
      
      function frame9() : *
      {
         this.flower_maskee.mask = this.oval_mask;
      }
   }
}
