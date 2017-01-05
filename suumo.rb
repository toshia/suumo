# -*- coding: utf-8 -*-

Plugin.create(:suumo) do
  キチガイ = "あ❗️%{name}(@%{sn})❗️🌚ダン💥ダン💥ダン💥シャーン🎶スモ🌝スモ🌚スモ🌝スモ🌚スモ 🌝スモ🌚ス〜〜〜モ⤴🌝スモ🌚スモ🌝スモ🌚スモ🌝スモ🌚スモ🌝ス〜〜〜モ⤵🌞"

  command(:suumo_this_user,
          name: 'スーモ',
          condition: lambda{ |opt| opt.messages.all?(&:repliable?) },
          visible: true,
          role: :timeline) do |opt|
    opt.messages.each do |message|
      opt.widget.create_postbox(to: message,
                                footer: キチガイ % {sn: message.user.idname, name: message.user[:name]})
    end
  end

  command(:quick_suumo,
          name: ->opt{
            if defined? opt.messages.first and opt.messages.first.repliable?
              u = opt.messages.first.user
              (_("あ！#{u[:name]}（@#{u[:idname]}）！") % {
                 screen_name: u[:idname],
                 name: u[:name] }).gsub(/_/, '__')
            else
              'クイックスーモ' end },
          condition: lambda{ |opt| opt.messages.size == 1 && opt.messages.all?(&:repliable?) },
          visible: true,
          role: :timeline) do |opt|
    opt.messages.each do |message|
      message.post(message: キチガイ % {sn: message.user.idname, name: message.user[:name]})
    end
  end
end
