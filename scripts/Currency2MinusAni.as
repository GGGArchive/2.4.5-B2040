package
{
   import flash.display.MovieClip;
   
   public dynamic class Currency2MinusAni extends MovieClip
   {
       
      
      public function Currency2MinusAni()
      {
         super();
         addFrameScript(19,this.frame20);
      }
      
      function frame20() : *
      {
         gotoAndStop(1);
      }
   }
}
