package com.goodgamestudios.mafia.vo.fight
{
   import com.goodgamestudios.mafia.constants.enums.ItemQuality;
   import com.goodgamestudios.mafia.constants.enums.ItemSubtype;
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   
   public class FightItemVO
   {
       
      
      public var id:int = 0;
      
      public var type:ItemType;
      
      public var subtype:ItemSubtype;
      
      public var quality:ItemQuality;
      
      public function FightItemVO()
      {
         this.type = ItemType.None;
         this.subtype = ItemSubtype.None;
         this.quality = ItemQuality.Normal;
         super();
      }
   }
}
