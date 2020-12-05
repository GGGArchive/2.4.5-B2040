package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Automat_Miami_1475 extends MovieClip
   {
       
      
      public var ani:MovieClip;
      
      public var off:MovieClip;
      
      public var hit:MovieClip;
      
      public function Automat_Miami_1475()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.off.visible = false;
      }
   }
}
