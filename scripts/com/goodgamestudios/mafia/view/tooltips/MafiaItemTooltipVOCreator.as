package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.enums.ItemType;
   import com.goodgamestudios.mafia.constants.enums.TooltipDispPosition;
   import com.goodgamestudios.mafia.view.MafiaToolTipManager;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaFightEquipmentTooltipProperties;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaItemAdvancedTooltipProperties;
   import com.goodgamestudios.mafia.vo.TooltipVO;
   import com.goodgamestudios.mafia.vo.items.ArmamentItemVO;
   import com.goodgamestudios.mafia.vo.items.ExtraVO;
   import com.goodgamestudios.mafia.vo.items.GearVO;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.geom.Point;
   
   public class MafiaItemTooltipVOCreator
   {
      
      private static var _tooltipCreator:MafiaItemTooltipVOCreator;
       
      
      public function MafiaItemTooltipVOCreator(param1:SingletonEnforcer#113)
      {
         super();
         if(_tooltipCreator)
         {
            throw new Error("Calling constructor not allowed! Use getInstance instead.");
         }
      }
      
      public static function get instance() : MafiaItemTooltipVOCreator
      {
         if(_tooltipCreator == null)
         {
            _tooltipCreator = new MafiaItemTooltipVOCreator(new SingletonEnforcer#113());
         }
         return _tooltipCreator;
      }
      
      public function creatTooltipVO(param1:ItemVO, param2:TooltipDispPosition, param3:Point = null, param4:int = 1) : TooltipVO
      {
         var _loc5_:TooltipVO = null;
         switch(param1.type)
         {
            case ItemType.Gear:
               _loc5_ = new TooltipVO(MafiaItemAdvancedTooltip.NAME,new MafiaItemAdvancedTooltipProperties(param1 as GearVO),param3,this.mapDispPosToBasic(param2),param4);
               break;
            case ItemType.Accessory:
            case ItemType.Consumable:
            case ItemType.Weapon:
            case ItemType.Skill:
               _loc5_ = new TooltipVO(MafiaAdvancedFightEquipmentTooltip.NAME,new MafiaFightEquipmentTooltipProperties(param1 as ArmamentItemVO),param3,this.mapDispPosToBasic(param2),param4);
               break;
            case ItemType.Food:
               _loc5_ = new TooltipVO(MafiaItemAdvancedTooltip.NAME,new MafiaItemAdvancedTooltipProperties(param1),param3,this.mapDispPosToBasic(param2),param4);
               break;
            case ItemType.Extra:
               _loc5_ = new TooltipVO(MafiaItemAdvancedTooltip.NAME,new MafiaItemAdvancedTooltipProperties(param1 as ExtraVO),param3,this.mapDispPosToBasic(param2),param4);
         }
         return _loc5_;
      }
      
      private function mapDispPosToBasic(param1:TooltipDispPosition) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case TooltipDispPosition.None:
               _loc2_ = "";
               break;
            case TooltipDispPosition.Center:
               _loc2_ = MafiaToolTipManager.CENTERDISPSTATICPOS;
               break;
            case TooltipDispPosition.Left:
               _loc2_ = MafiaToolTipManager.LEFTDISPMOUSEPOS;
               break;
            case TooltipDispPosition.Over:
               _loc2_ = MafiaToolTipManager.OVERDISPSTATICPOS;
               break;
            case TooltipDispPosition.Right:
               _loc2_ = MafiaToolTipManager.RIGHTDISPMOUSEPOS;
               break;
            case TooltipDispPosition.Top:
               _loc2_ = MafiaToolTipManager.TOPDISPMOUSEPOS;
         }
         return _loc2_;
      }
   }
}

class SingletonEnforcer#113
{
    
   
   function SingletonEnforcer#113()
   {
      super();
   }
}
