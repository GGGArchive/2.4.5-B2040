package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class ClanChat extends MovieClip
   {
       
      
      public var btn_chat:Btn_Chat;
      
      public var txt_online:TextField;
      
      public var txt_clanchat:TextField;
      
      public var btn_chatenter:Btn_SendChat;
      
      public var mc_onlinemember:ClanOnlineMemberComponent;
      
      public var mc_mask:MovieClip;
      
      public var input_BG:MovieClip;
      
      public var bg_chat:MovieClip;
      
      public var mc_textholder:emptyMC;
      
      public var txt_chatmsg:TextField;
      
      public var mc_chatslider:MovieClip;
      
      public function ClanChat()
      {
         super();
      }
   }
}
