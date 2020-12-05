package com.goodgamestudios.mafia.vo.items
{
   import com.goodgamestudios.basic.vo.BasicDragVO;
   import flash.display.MovieClip;
   
   public class ItemDragVO extends BasicDragVO
   {
       
      
      public var itemVO:ItemVO;
      
      public var item:MovieClip;
      
      public var sourceItemPic:MovieClip;
      
      public var backgroundGrid:MovieClip;
      
      public var backgroundBorder:MovieClip;
      
      public var dropIcon:MovieClip;
      
      public var dragAmount:uint;
      
      public function ItemDragVO()
      {
         super();
      }
   }
}
