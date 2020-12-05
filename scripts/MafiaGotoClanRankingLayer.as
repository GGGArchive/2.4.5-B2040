package
{
   import flash.display.MovieClip;
   
   public dynamic class MafiaGotoClanRankingLayer extends MovieClip
   {
       
      
      public var btn_toTroopRanking:Btn_ToClanRanking;
      
      public function MafiaGotoClanRankingLayer()
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
