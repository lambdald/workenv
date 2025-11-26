import win32api
import win32con

def get_supported_refresh_rates():
    """获取当前显示器支持的所有刷新率"""
    modes = []
    
    # 获取当前显示模式
    current_mode = win32api.EnumDisplaySettings(None, win32con.ENUM_CURRENT_SETTINGS)
    current_width = current_mode.PelsWidth
    current_height = current_mode.PelsHeight
    current_bpp = current_mode.BitsPerPel
    
    # 枚举所有显示模式
    i = 0
    while True:
        try:
            mode = win32api.EnumDisplaySettings(None, i)
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

def set_refresh_rate(frequency):

    devices = win32api.EnumDisplayMonitors()

    print('devices:', devices)

    """设置屏幕刷新率"""
    # 获取当前显示模式（这是一个PyDEVMODEW对象）
    devmode = win32api.EnumDisplaySettings(None, win32con.ENUM_CURRENT_SETTINGS)
    
    # 修改刷新率
    devmode.DisplayFrequency = frequency
    
    # 应用设置 - 使用正确的参数和类型
    result = win32api.ChangeDisplaySettingsEx(
        None,  # 设备名称，None表示主显示器
        devmode,  # 使用原生PyDEVMODEW对象
        win32con.CDS_UPDATEREGISTRY  # 标志：更新注册表
    )
    
    if result == win32con.DISP_CHANGE_SUCCESSFUL:
        return True, f"刷新率已成功设置为 {frequency} Hz"
    elif result == win32con.DISP_CHANGE_BADMODE:
        return False, f"不支持 {frequency} Hz 的刷新率"
    elif result == win32con.DISP_CHANGE_NOTUPDATED:
        return False, "无法更新显示设置"
    elif result == win32con.DISP_CHANGE_FAILED:
        return False, "设置失败，不支持的显示模式"
    elif result == win32con.DISP_CHANGE_RESTART:
        return False, "需要重启才能应用设置"
    else:
        return False, f"设置失败，错误代码: {result}"

if __name__ == "__main__":
    # 获取支持的刷新率
    supported_rates = get_supported_refresh_rates()
    print(f"当前显示器支持的刷新率: {supported_rates} Hz")
    
    # 示例：设置为最高刷新率
    if supported_rates:
        highest_rate = max(supported_rates)
        success, message = set_refresh_rate(highest_rate)
        print(message)
        
        # 示例：设置为60Hz（如果支持）
        # if 60 in supported_rates:
        #     success, message = set_refresh_rate(60)
        #     print(message)
        # else:
        #     print("不支持60Hz刷新率")
