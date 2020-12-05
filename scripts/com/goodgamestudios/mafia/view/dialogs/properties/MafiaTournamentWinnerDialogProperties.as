package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.tournament.TournamentRoundReportVO;
   
   public class MafiaTournamentWinnerDialogProperties extends BasicProperties
   {
       
      
      public var roundReportVO:TournamentRoundReportVO;
      
      public function MafiaTournamentWinnerDialogProperties(param1:TournamentRoundReportVO)
      {
         this.roundReportVO = param1;
         super();
      }
   }
}
