package com.goodgamestudios.mafia.controller
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.FightType;
   import com.goodgamestudios.mafia.event.model.MafiaFightEvent;
   import com.goodgamestudios.mafia.event.model.MafiaSurvivalEvent;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaSurvivalResultData;
   import flash.events.Event;
   
   public class MafiaSurvivalController
   {
      
      private static var _instance:MafiaSurvivalController;
       
      
      private var data:MafiaSurvivalResultData;
      
      public function MafiaSurvivalController(param1:SingletonEnforcer#109)
      {
         super();
      }
      
      public static function getInstance() : MafiaSurvivalController
      {
         if(!_instance)
         {
            _instance = new MafiaSurvivalController(new SingletonEnforcer#109());
         }
         return _instance;
      }
      
      public function startMultiFight(param1:MafiaSurvivalResultData) : void
      {
         if(param1 && param1.fights)
         {
            this.data = param1;
            this.data.round = 0;
            this.data.preCombatProfile = this.data.fights[0].fighterLeft;
            BasicController.getInstance().addEventListener(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED,this.onFightEnd);
            BasicController.getInstance().addEventListener(MafiaSurvivalEvent.BEGIN_OF_SURVIVAL_ANIMATION_FINISHED,this.onBeginOfSurvivalAnimationFinished);
            BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.START_MULTIFIGHT));
         }
         else
         {
            trace("Error: Multifight result data or fights are null");
         }
      }
      
      protected function onBeginOfSurvivalAnimationFinished(param1:Event) : void
      {
         this.nextFight();
      }
      
      private function onFightEnd(param1:Event) : void
      {
         this.removeDefeatedFighter();
         this.nextFight();
      }
      
      private function removeDefeatedFighter() : void
      {
         if(this.data.currentFight.isLeftFighterWinner)
         {
            this.data.fightersRight.shift();
            this.data.survivalProgress++;
            this.data.enemiesLeft--;
         }
         else
         {
            this.data.fightersLeft.shift();
         }
      }
      
      private function nextFight() : void
      {
         if(this.data.fights.length > 0)
         {
            this.data.currentFight = this.data.fights.shift();
            MafiaFightController.getInstance().startFight(this.data.currentFight,FightType.Survival);
            this.data.round++;
         }
         else
         {
            this.endMultiFight();
         }
      }
      
      private function endMultiFight() : void
      {
         BasicController.getInstance().removeEventListener(MafiaFightEvent.END_OF_COMBAT_ANIMATION_FINISHED,this.onFightEnd);
         BasicController.getInstance().removeEventListener(MafiaSurvivalEvent.BEGIN_OF_SURVIVAL_ANIMATION_FINISHED,this.onBeginOfSurvivalAnimationFinished);
         BasicController.getInstance().dispatchEvent(new MafiaFightEvent(MafiaFightEvent.END_MULTIFIGHT));
      }
   }
}

class SingletonEnforcer#109
{
    
   
   function SingletonEnforcer#109()
   {
      super();
   }
}
