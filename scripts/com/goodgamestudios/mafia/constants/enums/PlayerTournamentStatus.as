package com.goodgamestudios.mafia.constants.enums
{
   public class PlayerTournamentStatus extends BasicEnum
   {
      
      private static var _notParticipating:PlayerTournamentStatus;
      
      private static var _participating:PlayerTournamentStatus;
      
      private static var _eliminated:PlayerTournamentStatus;
       
      
      public function PlayerTournamentStatus(param1:String, param2:uint, param3:DoNotInstantiate#79)
      {
         super(param1,param2);
         if(param3 == null)
         {
            throwInstantiationError();
         }
      }
      
      public static function get NotParticipating() : PlayerTournamentStatus
      {
         if(_notParticipating == null)
         {
            _notParticipating = new PlayerTournamentStatus("NotParticipating",1,new DoNotInstantiate#79());
         }
         return _notParticipating;
      }
      
      public static function get Participating() : PlayerTournamentStatus
      {
         if(_participating == null)
         {
            _participating = new PlayerTournamentStatus("Participating",2,new DoNotInstantiate#79());
         }
         return _participating;
      }
      
      public static function get Eliminated() : PlayerTournamentStatus
      {
         if(_eliminated == null)
         {
            _eliminated = new PlayerTournamentStatus("Eliminated",3,new DoNotInstantiate#79());
         }
         return _eliminated;
      }
   }
}

class DoNotInstantiate#79
{
    
   
   function DoNotInstantiate#79()
   {
      super();
   }
}
