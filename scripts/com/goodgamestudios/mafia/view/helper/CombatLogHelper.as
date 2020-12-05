package com.goodgamestudios.mafia.view.helper
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.utils.MovieClipHelper;
   import com.goodgamestudios.mafia.constants.Constants_ViewScales;
   import com.goodgamestudios.mafia.constants.enums.ConsumableType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.PBFightActionType;
   import com.goodgamestudios.mafia.controller.protobuf.fight.fightaction.hit.PBFightActionHitResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.model.components.user.fightresult.MafiaFightResultData;
   import com.goodgamestudios.mafia.vo.fight.FightTurnVO;
   import com.goodgamestudios.mafia.vo.fight.actions.FightActionVO;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   
   public class CombatLogHelper extends ChatHelper
   {
      
      private static const MAX_MESSAGES_IN_VIEW:int = 10;
       
      
      private const SLIDER_START_POSITION:int = 100;
      
      private var colorRed:uint = 15356484;
      
      private var colorBlue:uint = 2463152;
      
      private const MAGIC_FOUR_OFFSET:int = 4;
      
      private const NAME_OFFSET:int = 20;
      
      private const TEXTHOLDER_INIT_Y_POS:Number = -84.05;
      
      private const MASK_INIT_Y_POS:Number = -85.6;
      
      public function CombatLogHelper(param1:MovieClip, param2:int = 0)
      {
         super(param1,this.SLIDER_START_POSITION);
         chatslider.StepSize = 2;
      }
      
      public function onAddTurnLogs(param1:Vector.<FightTurnVO>, param2:MafiaFightResultData) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:CombatLog_Result = null;
         var _loc7_:FightTurnVO = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc10_:CombatLogText = null;
         var _loc11_:CombatLog_SeperatorLine = null;
         var _loc3_:TextFormat = new TextFormat();
         var _loc6_:int = 0;
         _loc5_ = new CombatLog_Result();
         for each(_loc7_ in param1)
         {
            if(_loc7_.actions.length != 0)
            {
               _loc9_ = 0;
               while(_loc9_ < _loc7_.actions.length)
               {
                  _loc10_ = new CombatLogText();
                  _loc11_ = new CombatLog_SeperatorLine();
                  _loc10_.txt_player.text = MafiaModel.userData.userName;
                  _loc10_.txt_opponent.text = param2.fighterRight.name;
                  _loc4_ = _loc10_.txt_player.textWidth + _loc10_.txt_opponent.textWidth + this.NAME_OFFSET;
                  _loc10_.txt_player.text = "";
                  _loc10_.txt_opponent.text = "";
                  if(_loc7_.actions[_loc9_].type == PBFightActionType.HIT)
                  {
                     _loc3_.color = this.colorBlue;
                     _loc10_.txt_player.defaultTextFormat = _loc3_;
                     _loc10_.txt_player.text = MafiaModel.userData.userName;
                     _loc3_.color = this.colorRed;
                     _loc10_.txt_opponent.defaultTextFormat = _loc3_;
                     _loc10_.txt_opponent.text = param2.fighterRight.name;
                  }
                  else if(_loc7_.actions[_loc9_].type == PBFightActionType.CONSUME)
                  {
                     if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_LEFT)
                     {
                        if(_loc7_.actions[_loc9_].consume.item.subtype == ConsumableType.Healing)
                        {
                           _loc3_.color = this.colorBlue;
                           _loc10_.txt_player.defaultTextFormat = _loc3_;
                           _loc10_.txt_player.text = MafiaModel.userData.userName;
                        }
                     }
                     else if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_RIGHT)
                     {
                        if(_loc7_.actions[_loc9_].consume.item.subtype == ConsumableType.Healing)
                        {
                           _loc3_.color = this.colorRed;
                           _loc10_.txt_opponent.defaultTextFormat = _loc3_;
                           _loc10_.txt_opponent.text = param2.fighterRight.name;
                        }
                     }
                     if(_loc7_.actions[_loc9_].consume.item.subtype != ConsumableType.Healing)
                     {
                        _loc3_.color = this.colorBlue;
                        _loc10_.txt_player.defaultTextFormat = _loc3_;
                        _loc10_.txt_player.text = MafiaModel.userData.userName;
                        _loc3_.color = this.colorRed;
                        _loc10_.txt_opponent.defaultTextFormat = _loc3_;
                        _loc10_.txt_opponent.text = param2.fighterRight.name;
                     }
                  }
                  else if(_loc7_.actions[_loc9_].type == PBFightActionType.PASSIVE)
                  {
                     if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_LEFT)
                     {
                        _loc3_.color = this.colorBlue;
                        _loc10_.txt_player.defaultTextFormat = _loc3_;
                        _loc10_.txt_player.text = MafiaModel.userData.userName;
                     }
                     else if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_RIGHT)
                     {
                        _loc3_.color = this.colorRed;
                        _loc10_.txt_opponent.defaultTextFormat = _loc3_;
                        _loc10_.txt_opponent.text = param2.fighterRight.name;
                     }
                  }
                  if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_LEFT)
                  {
                     _loc10_.txt_opponent.x = _loc10_.txt_player.textWidth + this.NAME_OFFSET;
                     _loc10_.mc_itemholder.x = _loc10_.txt_opponent.x - 8;
                  }
                  if(_loc7_.fighterOnTurn == MafiaFightResultData.FIGHTER_RIGHT)
                  {
                     _loc10_.txt_player.x = _loc10_.txt_opponent.textWidth + this.NAME_OFFSET;
                     _loc10_.mc_itemholder.x = _loc10_.txt_player.x - 8;
                  }
                  _loc6_++;
                  _loc10_.txt_action.text = this.getActionText(_loc7_.actions[_loc9_],_loc6_);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc10_.txt_player);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc10_.txt_opponent);
                  BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc10_.txt_action);
                  _loc10_.txt_action.x = _loc4_;
                  _loc10_.mc_itemholder.addChild(this.getItemForAction(_loc7_.actions[_loc9_]));
                  _loc10_.txt_player.y = _loc10_.txt_opponent.y = _loc10_.txt_action.y = chatkomponent.mc_textholder.height;
                  _loc10_.mc_itemholder.y = chatkomponent.mc_textholder.height + 8;
                  _loc11_.y = chatkomponent.mc_textholder.height;
                  chatkomponent.mc_textholder.addChild(_loc10_);
                  chatkomponent.mc_textholder.addChild(_loc11_);
                  _loc9_++;
               }
               chatHeight = chatkomponent.mc_textholder.height;
            }
         }
         _loc5_.y = chatkomponent.mc_textholder.height + 10;
         if(param2.isLeftFighterWinner)
         {
            _loc8_ = MafiaModel.userData.userName;
            _loc5_.gotoAndStop(1);
         }
         else
         {
            _loc8_ = param2.fighterRight.name;
            _loc5_.gotoAndStop(2);
         }
         _loc5_.txt_result.text = MafiaModel.languageData.getTextById("MafiaCombatLogDialog_copy_3",[_loc8_]);
         chatkomponent.mc_textholder.addChild(_loc5_);
         _loc6_ = _loc6_ + 1;
         if(_loc6_ < MAX_MESSAGES_IN_VIEW)
         {
            enableSliderButtons(false);
         }
         else
         {
            enableSliderButtons(true);
         }
         chatHeight = chatkomponent.mc_textholder.height;
         BasicLanguageFontManager.getInstance().changeFontByLanguage(_loc5_.txt_result);
         scrollToEnd();
      }
      
      private function getItemForAction(param1:FightActionVO) : MovieClip
      {
         var _loc2_:MovieClip = null;
         var _loc3_:Icon_enrage_buff = null;
         switch(param1.type)
         {
            case PBFightActionType.HIT:
               _loc2_ = MafiaItemData.getInstance().generateItemPic(param1.hit.weapon.type,param1.hit.weapon.subtype,param1.hit.weapon.id,param1.hit.weapon.quality,true);
               _loc2_.scaleX = _loc2_.scaleY = Constants_ViewScales.SCALE_COMBATLOG_SMALL;
               break;
            case PBFightActionType.CONSUME:
               _loc2_ = MafiaItemData.getInstance().generateItemPic(param1.consume.item.type,param1.consume.item.subtype,param1.consume.item.id,param1.consume.item.quality,true);
               _loc2_.scaleX = _loc2_.scaleY = Constants_ViewScales.SCALE_COMBATLOG_SMALL;
               break;
            case PBFightActionType.PASSIVE:
               _loc3_ = new Icon_enrage_buff();
               _loc2_ = _loc3_;
               _loc2_.scaleX = _loc2_.scaleY = Constants_ViewScales.SCALE_COMBATLOG_RAGE;
         }
         return _loc2_;
      }
      
      private function getActionText(param1:FightActionVO, param2:int) : String
      {
         var _loc3_:* = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         switch(param1.type)
         {
            case PBFightActionType.HIT:
               if(param1.hit)
               {
                  switch(param1.hit.result)
                  {
                     case PBFightActionHitResult.HIT:
                        if(param1.hit.secondDamage > 0)
                        {
                           if(param1.hit.isCritical)
                           {
                              _loc3_ = NumberStringHelper.groupString(param1.hit.firstDamage,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg") + "(" + MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_6") + ")";
                           }
                           else
                           {
                              _loc3_ = NumberStringHelper.groupString(param1.hit.firstDamage,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
                           }
                        }
                        else if(param1.hit.isCritical)
                        {
                           _loc3_ = NumberStringHelper.groupString(param1.hit.firstDamage,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg") + "(" + MafiaModel.languageData.getTextById("MafiaAvatarScreen_itemEffectCompare_6") + ")";
                        }
                        else
                        {
                           _loc3_ = NumberStringHelper.groupString(param1.hit.firstDamage,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dmg");
                        }
                        break;
                     case PBFightActionHitResult.EVADED:
                        _loc3_ = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_dodge");
                        break;
                     case PBFightActionHitResult.MISSED:
                        _loc3_ = MafiaModel.languageData.getTextById("MafiaFightScreen_text_miss");
                        break;
                     default:
                        trace("ERROR: Unknown hit result");
                  }
               }
               break;
            case PBFightActionType.CONSUME:
               if(param1.consume.heal > 0)
               {
                  _loc3_ = "+" + NumberStringHelper.groupString(param1.consume.heal,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_health");
               }
               else if(param1.consume.damage > 0)
               {
                  _loc3_ = "-" + NumberStringHelper.groupString(param1.consume.damage,MafiaModel.languageData.getTextById) + " " + MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_health");
               }
               break;
            default:
               _loc3_ = "";
               trace("ERROR: Unknown fight action type");
         }
         if(param1.effect)
         {
            _loc4_ = param1.effect.description;
         }
         if(_loc3_ == "")
         {
            _loc5_ = "     -     " + _loc4_;
         }
         else if(_loc3_ != "" && param1.effect)
         {
            _loc5_ = "     -     " + _loc3_ + " / " + _loc4_;
         }
         else
         {
            _loc5_ = "     -     " + _loc3_;
         }
         return _loc5_;
      }
      
      override public function hide() : void
      {
         super.hide();
         super.destroy();
      }
      
      override public function init() : void
      {
         chatHeight = 0;
         MovieClipHelper.clearMovieClip(chatkomponent.mc_textholder);
         chatkomponent.mc_textholder.y = this.TEXTHOLDER_INIT_Y_POS;
         chatkomponent.mc_mask.y = this.MASK_INIT_Y_POS;
      }
   }
}
