package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.tournament.TournamentRoundReportVO;
   
   public class MafiaTournamentRoundReportDialogProperties extends BasicProperties
   {
       
      
      public var roundReportVO:TournamentRoundReportVO;
      
      public function MafiaTournamentRoundReportDialogProperties(param1:TournamentRoundReportVO)
      {
         this.roundReportVO = param1;
         super();
      }
   }
}
