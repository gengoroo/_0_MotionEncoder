function make_shortcut(fnfull_original,shortcutDir,shortcutName)
        shell = actxserver('WScript.Shell');
        shortcut = shell.CreateShortcut(fullfile(shortcutDir, [shortcutName, '.lnk']));
        shortcut.TargetPath = fnfull_original;
        shortcut.Save();
        disp(['ショートカットが作成されました: ' fullfile(shortcutDir, shortcutName)]);
end