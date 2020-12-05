package
{
   import flash.display.MovieClip;
   
   public dynamic class RankingChangePosition extends MovieClip
   {
       
      
      public function RankingChangePosition()
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
