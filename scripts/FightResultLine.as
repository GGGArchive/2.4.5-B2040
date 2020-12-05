package
{
   import flash.display.MovieClip;
   
   public dynamic class FightResultLine extends MovieClip
   {
       
      
      public function FightResultLine()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         this.mouseEnabled = false;
      }
   }
}
