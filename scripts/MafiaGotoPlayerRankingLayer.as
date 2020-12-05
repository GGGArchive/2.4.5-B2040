package
{
   import flash.display.MovieClip;
   
   public dynamic class MafiaGotoPlayerRankingLayer extends MovieClip
   {
       
      
      public var btn_toPlayerRanking:Btn_ToPlayerRanking;
      
      public function MafiaGotoPlayerRankingLayer()
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
