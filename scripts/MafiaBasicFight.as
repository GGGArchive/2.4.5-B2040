package
{
   import flash.display.MovieClip;
   
   public dynamic class MafiaBasicFight extends MovieClip
   {
       
      
      public var actionAniHolder:emptyMC;
      
      public var policeResultTooltip:MafiaPoliceFightResultTooltip;
      
      public var fighterLeft:LeftFightAttendantExtended;
      
      public var blankResultTooltip:MafiaBlankFightResultTooltip;
      
      public var btn_skip:MafiaBasicButtonBlue;
      
      public var result:DynamicFightResult;
      
      public var tournamentSpectatorResultTooltip:MafiaTournamentSpectatorResultTooltip;
      
      public var fighterRight:RightFightAttendantExtended;
      
      public var backgroundHolder:emptyMC;
      
      public function MafiaBasicFight()
      {
         super();
      }
   }
}
