package MafiaInterface_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Currency2TextAni_197 extends MovieClip
   {
       
      
      public var value:MovieClip;
      
      public function Currency2TextAni_197()
      {
         super();
         addFrameScript(0,this.frame1,10,this.frame11);
      }
      
      function frame1() : *
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      function frame11() : *
      {
         gotoAndStop(1);
      }
   }
}
