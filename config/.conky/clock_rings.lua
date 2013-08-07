--[[
Clock Rings by Linux Mint (2011) reEdited by despot77

This script draws percentage meters as rings, and also draws clock hands if you want! It is fully customisable; all options are described in the script. This script is based off a combination of my clock.lua script and my rings.lua script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement on line 145 uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num>5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num>3; conversely if you update Conky every 0.5s, you should use update_num>10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
    lua_load ~/scripts/clock_rings.lua
    lua_draw_hook_pre clock_rings
    
Changelog:
+ v1.0 -- Original release (30.09.2009)
   v1.1p -- Jpope edit londonali1010 (05.10.2009)
*v 2011mint -- reEdit despot77 (18.02.2011)
]]

-- "name" is the type of stat to display; you can choose from:
-- 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.

settings_table = {
    {
        name='time',
        arg='%I.%M',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.2,
        x=100, y=150,
        radius=50,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%M.%S',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.4,
        x=100, y=150,
        radius=56,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%S',
        max=60,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.6,
        x=100, y=150,
        radius=62,
        thickness=5,
        start_angle=0,
        end_angle=360
    },
    {
        name='time',
        arg='%d',
        max=31,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=100, y=150,
        radius=70,
        thickness=5,
        start_angle=-90,
        end_angle=90
    },
    {
        name='time',
        arg='%m',
        max=12,
        bg_colour=0xffffff,
        bg_alpha=0.1,
        fg_colour=0x0066FF,
        fg_alpha=1,
        x=100, y=150,
        radius=76,
        thickness=5,
        start_angle=-90,
        end_angle=90
    },
    {
        name='acpitemp',
        arg='',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {
              {["val"] = 0.60, ["col"]=0xFFCA00},
              {["val"] = 0.70, ["col"]=0xFF9D00},
              {["val"] = 0.80, ["col"]=0xFF3300},
              {["val"] = 0.90, ["col"]=0xFF4D00},
             },
        x=50, y=300,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=45
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=20,
        thickness=4,
        start_angle=45,
        end_angle=180
    },
    {
        name='cpu',
        arg='cpu2',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=15,
        thickness=4,
        start_angle=-90,
        end_angle=45
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=15,
        thickness=4,
        start_angle=45,
        end_angle=180
    },
    {
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=10,
        thickness=4,
        start_angle=-90,
        end_angle=45
    },
    {
        name='cpu',
        arg='cpu5',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=10,
        thickness=4,
        start_angle=45,
        end_angle=180
    },
    {
        name='cpu',
        arg='cpu6',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=5,
        thickness=4,
        start_angle=-90,
        end_angle=45
    },
    {
        name='cpu',
        arg='cpu7',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.50, ["col"]=0xFF4D00}, {["val"] = 0.75, ["col"]=0xFF3300}},
        x=50, y=300,
        radius=5,
        thickness=4,
        start_angle=45,
        end_angle=180
    },
    {
        name='memperc',
        arg='',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.75, ["col"]=0xFF4D00}, {["val"] = 0.85, ["col"]=0xFF3300}},
        x=75, y=350,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='swapperc',
        arg='',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.75, ["col"]=0xFF4D00}, {["val"] = 0.85, ["col"]=0xFF3300}},
        x=75, y=350,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.75, ["col"]=0xFF4D00}, {["val"] = 0.90, ["col"]=0xFF3300}},
        x=100, y=400,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/mnt/data',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.75, ["col"]=0xFF4D00}, {["val"] = 0.90, ["col"]=0xFF3300}},
        x=100, y=400,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='fs_used_perc',
        arg='/mnt/d',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {{["val"] = 0.75, ["col"]=0xFF4D00}, {["val"] = 0.90, ["col"]=0xFF3300}},
        x=100, y=400,
        radius=15,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
        {
        name='downspeedf',
        arg='wlan0',
        max=1500,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=125, y=450,
        radius=25,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
        {
        name='upspeedf',
        arg='wlan0',
        max=150,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0xff3300,
        fg_alpha=0.8,
        x=125, y=450,
        radius=20,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
        {
        name='downspeedf',
        arg='eth0',
        max=1500,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        x=125, y=450,
        radius=15,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
        {
        name='upspeedf',
        arg='eth0',
        max=120,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0xff3300,
        fg_alpha=0.8,
        x=125, y=450,
        radius=10,
        thickness=4,
        start_angle=-90,
        end_angle=180
    },
    {
        name='exec',
        arg='acpi -b | acpi -b | awk \'BEGIN { FS = " " } ; { print $4 }\' | sed \'s/%.*//\'',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {  {["val"] = 0.51, ["col"]=0x0066FF},
                {["val"] = 0.26, ["col"]=0xFF4D00},
                {["val"] = 0.00, ["col"]=0xFF3300}},
        x=150, y=500,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180
    },
    {
        name='wireless_link_qual_perc',
        arg='wlan0',
        max=100,
        bg_colour=0xffffff,
        bg_alpha=0.2,
        fg_colour=0x0066FF,
        fg_alpha=0.8,
        fg = {  {["val"] = 0.51, ["col"]=0x0066FF},
                {["val"] = 0.26, ["col"]=0xFF4D00},
                {["val"] = 0.00, ["col"]=0xFF3300}},
        x=175, y=550,
        radius=25,
        thickness=5,
        start_angle=-90,
        end_angle=180
    },
}

-- Use these settings to define the origin and extent of your clock.

clock_r=65

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=100
clock_y=150

show_seconds=true

for i,n in pairs(settings_table) do
  if n['fg'] ~= nil then
    table.sort(n['fg'], function(lhs, rhs) return lhs['val'] < rhs['val'] end)
  end
end

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
    local w,h=conky_window.width,conky_window.height

    local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
    local bgc, bga=pt['bg_colour'], pt['bg_alpha']
    local fgc, fga=pt['fg_colour'], pt['fg_alpha']

    if pt['fg'] ~= nil then
        for i,n in pairs(pt['fg']) do
          if n['val'] > t then
            break
          end
          fgc = n['col']
        end
    end

    local angle_0=sa*(2*math.pi/360)-math.pi/2
    local angle_f=ea*(2*math.pi/360)-math.pi/2
    local t_arc=t*(angle_f-angle_0)

    -- Draw background ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
    cairo_set_line_width(cr,ring_w)
    cairo_stroke(cr)

    -- Draw indicator ring

    cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
    cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
    local secs,mins,hours,secs_arc,mins_arc,hours_arc
    local xh,yh,xm,ym,xs,ys
    
    secs=os.date("%S")    
    mins=os.date("%M")
    hours=os.date("%I")
        
    secs_arc=(2*math.pi/60)*secs
    mins_arc=(2*math.pi/60)*mins+secs_arc/60
    hours_arc=(2*math.pi/12)*hours+mins_arc/12
        
    -- Draw hour hand
    
    xh=xc+0.7*clock_r*math.sin(hours_arc)
    yh=yc-0.7*clock_r*math.cos(hours_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xh,yh)
    
    cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
    cairo_set_line_width(cr,5)
    cairo_set_source_rgba(cr,1.0,1.0,1.0,1.0)
    cairo_stroke(cr)
    
    -- Draw minute hand
    
    xm=xc+clock_r*math.sin(mins_arc)
    ym=yc-clock_r*math.cos(mins_arc)
    cairo_move_to(cr,xc,yc)
    cairo_line_to(cr,xm,ym)
    
    cairo_set_line_width(cr,3)
    cairo_stroke(cr)
    
    -- Draw seconds hand
    
    if show_seconds then
        xs=xc+clock_r*math.sin(secs_arc)
        ys=yc-clock_r*math.cos(secs_arc)
        cairo_move_to(cr,xc,yc)
        cairo_line_to(cr,xs,ys)
    
        cairo_set_line_width(cr,1)
        cairo_stroke(cr)
    end
end

function conky_clock_rings()
    local function setup_rings(cr,pt)
        local str=''
        local value=0

        str=string.format('${%s %s}',pt['name'],pt['arg'])
        str=conky_parse(str)

        value=tonumber(str)
        if not value
        then
          value = 0
        end
        pct=value/pt['max']

        draw_ring(cr,pct,pt)
    end

    -- Check that Conky has been running for at least 5s

    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
    
    local cr=cairo_create(cs)    
    
    local updates=conky_parse('${updates}')
    update_num=tonumber(updates)
    
    if update_num>5 then
        for i in pairs(settings_table) do
            setup_rings(cr,settings_table[i])
        end
    end
    
    draw_clock_hands(cr,clock_x,clock_y)
end
