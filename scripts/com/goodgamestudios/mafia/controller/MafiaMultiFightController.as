package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaMultiFightResultData;
   import flash.events.Event;
   
   public class MafiaMultiFightController
   {
      
      private static var _instance:MafiaMultiFightController;
      
      private static var data:MafiaMultiFightResultData;
       
      
      private var lastFightType:FightType;
      
      public function MafiaMultiFightController(param1:SingletonEnforcer#119)
      {
         super();
      }
      
      public static function getInstance() : MafiaMultiFightController
      {
         if(!_instance)
         {
            _instance = new MafiaMultiFightController(new SingletonEnforcer#119());
         }
         return _instance;
      }
      
      public function startMultiFight(param1:MafiaMultiFightResultData, param2:FightType) : void
      {
         if(param1 && param1.fights)
         {
            data = param1;
            data.skip = false;
            this.lastFightType = param2;
            BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.START_MULTIFIGHT));
            BasicController.getInstance().addEventListener(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED,this.onFightEnd);
            BasicController.getInstance().addEventListener(MafiaFightEvent.SKIP_COMBAT,this.onSkipCombat);
            this.nextFight();
         }
         else
         {
            trace("Error: Multifight result data or fights are null");
         }
      }
      
      protected function onSkipCombat(param1:Event) : void
      {
         data.skip = true;
      }
      
      private function onFightEnd(param1:Event) : void
      {
         this.removeDefeatedFighter();
         this.nextFight();
      }
      
      private function removeDefeatedFighter() : void
      {
         if(data.currentFight.isLeftFighterWinner)
         {
            data.fightersRight.shift();
         }
         else
         {
            data.fightersLeft.shift();
         }
      }
      
      private function nextFight() : void
      {
         if(data.fights.length > 0)
         {
            data.currentFight = data.fights.shift();
            if(data.currentFight.fighterLeft.id == MafiaModel.userData.playerID)
            {
               data.currentFight.skip = data.skip = false;
            }
            else
            {
               data.currentFight.skip = data.skip;
            }
            data.fightersLeft[0] = data.currentFight.fighterLeft;
            data.fightersRight[0] = data.currentFight.fighterRight;
            MafiaFightController.getInstance().startFight(data.currentFight,this.lastFightType);
         }
         else
         {
            this.endMultiFight();
         }
      }
      
      private function endMultiFight() : void
      {
         BasicController.getInstance().removeEventListener(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED,this.onFightEnd);
         BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_MULTIFIGHT));
      }
   }
}

class SingletonEnforcer#119
{
    
   
   function SingletonEnforcer#119()
   {
      super();
   }
}
