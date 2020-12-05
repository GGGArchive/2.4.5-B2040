package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.mafia.constants.enums.ItemLocation;
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemSubtype;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.vo.items.components.BasicItemComponent;
   import com.goodgamestudios.mafia.vo.items.components.StackableComponent;
   
   public class ItemVO
   {
       
      
      private var components:Vector.<BasicItemComponent>;
      
      public var id:int = 0;
      
      public var type:ItemType;
      
      public var subtype:ItemSubtype;
      
      public var quality:ItemQuality;
      
      public var minUnlockLevel:int;
      
      public var maxUnlockLevel:int;
      
      public var location:ItemLocation;
      
      public var slotId:int = 0;
      
      public var cash:Number = 0;
      
      public var gold:Number = 0;
      
      public var saleCash:Number = 0;
      
      public var name:String;
      
      public var categoryName:String;
      
      public var categoryNameWithoutQuality:String;
      
      public var subcategoryName:String;
      
      public var qualityName:String;
      
      public var rounds:uint = 0;
      
      public function ItemVO()
      {
         this.type = ItemType.None;
         this.subtype = ItemSubtype.None;
         this.quality = ItemQuality.Normal;
         this.location = ItemLocation.None;
         super();
         this.components = new Vector.<BasicItemComponent>();
      }
      
      protected function addComponent(param1:BasicItemComponent) : void
      {
         this.components.push(param1);
      }
      
      public function getComponent(param1:Class) : BasicItemComponent
      {
         var _loc2_:BasicItemComponent = null;
         for each(_loc2_ in this.components)
         {
            if(_loc2_ is param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function hasComponent(param1:Class) : Boolean
      {
         return this.getComponent(param1) != null;
      }
      
      public function get amount() : uint
      {
         var _loc1_:StackableComponent = this.getComponent(StackableComponent) as StackableComponent;
         return _loc1_ != null?uint(_loc1_.amount):uint(1);
      }
   }
}
