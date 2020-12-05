package com.goodgamestudios.mafia.model.components
{
   public class MafiaGoldConstantsData
   {
       
      
      public var createClanPrice:Number;
      
      public var changeAvatarPrice:Number;
      
      public var fillEnergyPrice:Number;
      
      public var cutMissionPricePerSecond:Number;
      
      public var maxSlotMashineInput:Number;
      
      public var cutNextFreeDuelTimePricePerSecond:Number;
      
      public var cutNextFreeWantedTimePricePerSecond:Number;
      
      public var cutNextFreeSurviavalTimePricePerSecond:Number;
      
      public var cutNextFreeDungeonTimePricePerSecond:Number;
      
      public var newShopItemsPrice:Number;
      
      public var newKioskItemsPrice:Number;
      
      public var cutFlightPricePerSecond:Number;
      
      public var emailVerificationGold:Number;
      
      public var levelUpGold:Number;
      
      public var tutorialReward:Number;
      
      public var unlockGangMemberSlot:Number;
      
      public var bailCost:int;
      
      public function MafiaGoldConstantsData()
      {
         super();
      }
      
      public function parseData(param1:Array) : void
      {
         param1.shift();
         var _loc2_:Array = String(param1.shift()).split("+");
         this.createClanPrice = _loc2_.shift();
         this.changeAvatarPrice = _loc2_.shift();
         this.fillEnergyPrice = _loc2_.shift();
         this.cutMissionPricePerSecond = _loc2_.shift();
         this.maxSlotMashineInput = _loc2_.shift();
         this.cutNextFreeDuelTimePricePerSecond = _loc2_.shift();
         this.cutNextFreeWantedTimePricePerSecond = _loc2_.shift();
         this.cutNextFreeSurviavalTimePricePerSecond = _loc2_.shift();
         this.cutNextFreeDungeonTimePricePerSecond = _loc2_.shift();
         this.newShopItemsPrice = _loc2_.shift();
         this.newKioskItemsPrice = _loc2_.shift();
         this.cutFlightPricePerSecond = _loc2_.shift();
         this.emailVerificationGold = _loc2_.shift();
         this.levelUpGold = _loc2_.shift();
         this.tutorialReward = _loc2_.shift();
         this.unlockGangMemberSlot = _loc2_.shift();
         this.bailCost = _loc2_.shift();
      }
   }
}
