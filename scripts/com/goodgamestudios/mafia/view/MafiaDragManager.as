package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicDragManager;
   import com.goodgamestudios.basic.vo.BasicDragVO;
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.components.MafiaArmamentGrid;
   import com.goodgamestudios.mafia.vo.items.ItemDragVO;
   import com.goodgamestudios.mafia.vo.items.components.ArmamentItemComponent;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.ui.ContextMenu;
   
   public class MafiaDragManager extends BasicDragManager
   {
       
      
      public function MafiaDragManager(param1:Sprite, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function startDragging(param1:BasicDragVO) : void
      {
         this.dragVO = param1;
         var _loc2_:ItemDragVO = param1 as ItemDragVO;
         var _loc3_:Array = _loc2_.sourceItemPic.filters.concat();
         var _loc4_:ColorMatrix = new ColorMatrix();
         _loc4_.desaturate();
         _loc3_.push(_loc4_.filter);
         _loc2_.sourceItemPic.filters = _loc3_;
         dragVO.dragSourceMC.alpha = _alpha;
         dragVO.dragMC = new MovieClip();
         _loc2_.item = MafiaItemData.getInstance().generateItemIcon(_loc2_.itemVO);
         dragVO.dragMC.addChild(_loc2_.item);
         if(_loc2_.itemVO.hasComponent(ArmamentItemComponent))
         {
            _loc2_.backgroundGrid = MafiaArmamentGrid.createArmamentBackgroundGrid(_loc2_.itemVO);
            _loc2_.dragMC.addChild(_loc2_.backgroundGrid);
            _loc2_.dragMC.setChildIndex(_loc2_.backgroundGrid,0);
            _loc2_.backgroundGrid.visible = false;
            _loc2_.backgroundBorder = MafiaArmamentGrid.createArmamentBackgroundBorder(_loc2_.itemVO);
            _loc2_.dragMC.addChild(_loc2_.backgroundBorder);
            _loc2_.dropIcon = MafiaArmamentGrid.createArmamentDropIcon(_loc2_.itemVO);
            _loc2_.dragMC.addChild(_loc2_.dropIcon);
         }
         dragVO.dragMC.scaleX = dragVO.dragMC.scaleY = this.layoutManager.scaleFactor;
         dragVO.dragMC.x = dragLayer.mouseX + _posX;
         dragVO.dragMC.y = dragLayer.mouseY - _posY;
         dragVO.dragMC.startDrag();
         dragLayer.addChildAt(dragVO.dragMC,0);
         this.layoutManager.stage.addEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         var _loc5_:InteractiveObject = dragLayer.root as InteractiveObject;
         if(_loc5_.contextMenu == null)
         {
            _loc5_.contextMenu = new ContextMenu();
         }
         _loc5_.contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,this.onOpenContextMenu);
      }
      
      protected function onOpenContextMenu(param1:ContextMenuEvent) : void
      {
         this.stopDragging();
      }
      
      override public function stopDragging() : void
      {
         if(!dragVO)
         {
            return;
         }
         var _loc1_:ItemDragVO = dragVO as ItemDragVO;
         var _loc2_:Array = _loc1_.sourceItemPic.filters;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] is ColorMatrixFilter)
            {
               _loc2_.splice(_loc3_,1);
            }
            _loc3_++;
         }
         _loc1_.sourceItemPic.filters = _loc2_;
         dragVO.dragSourceMC.alpha = _alpha;
         this.layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_EQUIP_HELP,[null,null,0]));
         this.layoutManager.stage.removeEventListener(Event.MOUSE_LEAVE,this.onMouseLeave);
         var _loc4_:InteractiveObject = dragLayer.root as InteractiveObject;
         _loc4_.contextMenu.removeEventListener(ContextMenuEvent.MENU_SELECT,this.onOpenContextMenu);
         super.stopDragging();
      }
      
      private function onMouseLeave(param1:Event) : void
      {
         this.stopDragging();
      }
      
      protected function get layoutManager() : MafiaLayoutManager
      {
         return MafiaLayoutManager.getInstance();
      }
   }
}
