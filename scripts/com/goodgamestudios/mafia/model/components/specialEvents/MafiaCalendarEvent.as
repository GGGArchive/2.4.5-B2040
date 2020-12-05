package com.goodgamestudios.mafia.model.components.specialEvents
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.constants.Constants_SpecialEvents;
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.controller.protobuf.specialevent.specialcalendar.PBSpecialeventSpecialCalendarResponse;
   import com.goodgamestudios.mafia.event.model.MafiaSpecialEventsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.dialogs.MafiaCalendarEventDialog;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import com.goodgamestudios.stringhelper.TimeStringHelper;
   import flash.utils.getTimer;
   
   public class MafiaCalendarEvent extends MafiaSpecialEvent
   {
      
      public static const NUMBER_OF_ENEMIES:int = 25;
      
      public static const START_PIC_ID:int = 101;
      
      public static const BOSS_PIC_ID:int = 125;
      
      public static const ENEMY_NAME_LIST:Array = [[3,39,false],[9,55,true],[24,37,true],[15,24,true],[26,2,true],[21,20,true],[11,60,true],[30,39,false],[15,56,false],[29,41,false],[12,48,true],[22,11,true],[6,32,true],[2,55,true],[24,20,false],[15,58,true],[19,52,true],[7,39,false],[3,38,true],[15,33,true],[29,55,true],[20,3,false],[17,44,true],[17,37,false]];
      
      public static const UNLOCK_DAY_GOLD_COST:int = 500;
       
      
      public var enemiesDefeated:Vector.<Boolean>;
      
      public var nextToUnlock:int;
      
      private var nextUnlockTimeInMSeconds:int;
      
      private const DAY_IN_MS:int = 8.64E7;
      
      public var item:ItemVO;
      
      private var _killedBossRightNow:Boolean;
      
      public function MafiaCalendarEvent()
      {
         _eventId = Constants_SpecialEvents.ID_CALENDAR;
         super();
      }
      
      public function parseEventDetails(param1:PBSpecialeventSpecialCalendarResponse) : void
      {
         this.enemiesDefeated = new Vector.<Boolean>(NUMBER_OF_ENEMIES);
         var _loc2_:int = 0;
         while(_loc2_ < param1.enemyDefeated.length)
         {
            this.enemiesDefeated[_loc2_] = param1.enemyDefeated[_loc2_];
            _loc2_++;
         }
         while(_loc2_ < NUMBER_OF_ENEMIES)
         {
            this.enemiesDefeated[_loc2_] = false;
            _loc2_++;
         }
         this.nextToUnlock = param1.enemyDefeated.length;
         if(param1.timeUntilNextUnlock > 0)
         {
            this.nextUnlockTimeInMSeconds = getTimer() + param1.timeUntilNextUnlock * Constants_Basic.SEC2MILLISEC;
         }
         else
         {
            this.nextUnlockTimeInMSeconds = 0;
         }
         if(param1.hasItem)
         {
            this.item = MafiaItemData.parseItem(param1.item,ItemLocation.None,0);
         }
         else
         {
            this.item = null;
         }
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CALENDAR_EVENT_DATA_UPDATED,[this]));
      }
      
      override public function update(param1:Number) : void
      {
         var _loc2_:Array = null;
         if(this.nextUnlockTimeInMSeconds > 0)
         {
            _loc2_ = [TimeStringHelper.getTimeToString((this.nextUnlockTimeInMSeconds - param1) * Constants_Basic.MILLISEC2SEC,TimeStringHelper.TWO_TIME_FORMAT,MafiaModel.languageData.getTextById)];
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CALENDAR_NEXT_UNLOCK_TIME,_loc2_));
            if(param1 > this.nextUnlockTimeInMSeconds)
            {
               this.nextUnlockTimeInMSeconds = 0;
               MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_CALENDAR]);
            }
         }
         if(runTimeInSeconds > 0)
         {
            BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CALENDAR_TIME_UPDATE,[runTimeString]));
         }
         else if(!waitForServerMessage)
         {
            waitForServerMessage = true;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_CALENDAR]);
         }
         if(this._killedBossRightNow && !MafiaDialogHandler.getInstance().blockDialogs && !waitForServerMessage)
         {
            this._killedBossRightNow = false;
            waitForServerMessage = true;
            MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_SHOW_ACTIVE_EVENTS,[Constants_SpecialEvents.ID_CALENDAR]);
            MafiaDialogHandler.getInstance().registerDialogs(MafiaCalendarEventDialog.NAME,null,true,BasicDialogHandler.PRIORITY_HIGH);
         }
      }
      
      override protected function eventEnded() : void
      {
         trace("calendar event ended!");
         MafiaModel.smartfoxClient.sendMessage(Constants_SFS.C2S_VIEW_WANTED_FIGHT,[]);
         BasicController.getInstance().dispatchEvent(new MafiaSpecialEventsEvent(MafiaSpecialEventsEvent.CALENDAR_EVENT_ENDED,[]));
      }
      
      public function get bossName() : String
      {
         return MafiaModel.languageData.getTextById("event_jahbandulu_copy_1");
      }
      
      override public function get eventTitle() : String
      {
         return MafiaModel.languageData.getTextById("event_jahbandulu_copy_1");
      }
      
      public function get eventSubtitle() : String
      {
         return MafiaModel.languageData.getTextById("event_jahbandulu_copy_2");
      }
      
      public function get isBossDead() : Boolean
      {
         return this.enemiesDefeated[NUMBER_OF_ENEMIES - 1];
      }
      
      public function get areAllUnlocked() : Boolean
      {
         return this.nextToUnlock >= NUMBER_OF_ENEMIES - 1;
      }
      
      public function isEnemyUnlocked(param1:int) : Boolean
      {
         return param1 < this.nextToUnlock;
      }
      
      public function isEnemyDefeated(param1:int) : Boolean
      {
         return this.enemiesDefeated[param1];
      }
      
      public function canEnemyBeFought(param1:int) : Boolean
      {
         return this.isEnemyUnlocked(param1) && !this.isEnemyDefeated(param1);
      }
      
      public function canEnemyBeUnlocked(param1:int) : Boolean
      {
         return param1 == this.nextToUnlock;
      }
      
      public function timeUntilUnlockOfEnemy(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = -1;
         if(param1 == this.nextToUnlock)
         {
            _loc2_ = this.nextUnlockTimeInMSeconds;
         }
         else if(param1 > this.nextToUnlock)
         {
            _loc3_ = param1 - this.nextToUnlock;
            _loc2_ = this.nextUnlockTimeInMSeconds + _loc3_ * this.DAY_IN_MS;
         }
         return _loc2_;
      }
      
      public function get killedBossRightNow() : Boolean
      {
         return this._killedBossRightNow;
      }
      
      public function set killedBossRightNow(param1:Boolean) : void
      {
         this._killedBossRightNow = param1;
      }
   }
}
