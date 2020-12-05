package
{
   import flash.display.MovieClip;
   
   public dynamic class RankingOpenCloseButton extends MovieClip
   {
       
      
      public function RankingOpenCloseButton()
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
