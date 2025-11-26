import win32api
import win32con

def get_all_monitors():
    """获取所有显示器的信息"""
    monitors = []
    i = 0
    while True:
        try:
            # 枚举显示设备
            dev = win32api.EnumDisplayDevices(None, i)
            if dev.StateFlags & win32con.DISPLAY_DEVICE_ATTACHED_TO_DESKTOP:
                monitors.append({
                    "index": i,
                    "device_name": dev.DeviceName,
                    "device_string": dev.DeviceString  # 显示器名称
                })
            i += 1
        except:
            break
    return monitors

def get_supported_refresh_rates(device_name=None):
    """获取指定显示器支持的所有刷新率"""
    modes = []
    
    # 获取当前显示模式
    current_mode = win32api.EnumDisplaySettings(device_name, win32con.ENUM_CURRENT_SETTINGS)
    current_width = current_mode.PelsWidth
    current_height = current_mode.PelsHeight
    current_bpp = current_mode.BitsPerPel
    
    # 枚举所有显示模式
    i = 0
    while True:
        try:
            mode = win32api.EnumDisplaySettings(device_name, i)
            # 只保留与当前分辨率和色深相同的模式
            if (mode.PelsWidth == current_width and 
                mode.PelsHeight == current_height and 
                mode.BitsPerPel == current_bpp):
                if mode.DisplayFrequency not in modes:
                    modes.append(mode.DisplayFrequency)
            i += 1
        except:
            break
    
    return sorted(modes)

def set_refresh_rate(frequency, device_name=None):
    """设置指定显示器的刷新率"""
    # 获取当前显示模式（原生PyDEVMODEW对象）
    devmode = win32api.EnumDisplaySettings(device_name, win32con.ENUM_CURRENT_SETTINGS)
    
    # 修改刷新率
    devmode.DisplayFrequency = frequency
    
    # 应用设置
    result = win32api.ChangeDisplaySettingsEx(
        device_name,  # 指定显示器设备名称
        devmode,
        win32con.CDS_UPDATEREGISTRY
    )
    
    # 错误代码解释
    error_messages = {
        win32con.DISP_CHANGE_SUCCESSFUL: f"刷新率已成功设置为 {frequency} Hz",
        win32con.DISP_CHANGE_BADMODE: f"不支持 {frequency} Hz 的刷新率",
        win32con.DISP_CHANGE_NOTUPDATED: "无法更新显示设置",
        win32con.DISP_CHANGE_FAILED: "设置失败，不支持的显示模式",
        win32con.DISP_CHANGE_RESTART: "需要重启才能应用设置"
    }
    
    success = result == win32con.DISP_CHANGE_SUCCESSFUL
    message = error_messages.get(result, f"设置失败，错误代码: {result}")
    return success, message

if __name__ == "__main__":
    # 获取所有显示器
    monitors = get_all_monitors()
    
    if not monitors:
        print("未检测到显示器")
        exit()
    
    # 显示显示器列表
    print("检测到的显示器:")
    for idx, monitor in enumerate(monitors):
        print(f"{idx + 1}. {monitor['device_string']} (设备名: {monitor['device_name']})")
    
    # 选择目标显示器
    try:
        selection = int(input("\n请选择要设置的显示器编号 (1-{}): ".format(len(monitors)))) - 1
        target_monitor = monitors[selection]
        print(f"已选择: {target_monitor['device_string']}")
    except (ValueError, IndexError):
        print("无效的选择")
        exit()
    
    # 获取并显示支持的刷新率
    supported_rates = get_supported_refresh_rates(target_monitor['device_name'])
    print(f"\n该显示器支持的刷新率: {supported_rates} Hz")
    
    # 设置刷新率
    if supported_rates:
        try:
            rate = int(input(f"请输入要设置的刷新率 ({'、'.join(map(str, supported_rates))}): "))
            if rate not in supported_rates:
                print(f"错误: 不支持 {rate} Hz")
                exit()
            
            success, message = set_refresh_rate(rate, target_monitor['device_name'])
            print(message)
        except ValueError:
            print("无效的刷新率")
