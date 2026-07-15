{ inputs, ... }: {
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default = {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
      };

      search = { force = true; default = "ddg"; };

      containersForce = true;
      containers = {
        Personal = { 
          color = "purple"; 
          icon = "fingerprint"; 
          id = 1; 
        };
        Work = { 
          color = "blue";   
          icon = "briefcase";  
          id = 2; 
        };
        Scratchpad = { 
          color = "yellow"; 
          icon = "fruit";     # Valid alternative (closest to folder/scratch)
          id = 3; 
        };
      };

      spacesForce = true;
      spaces = {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
          container = 1;
        };
        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
          container = 2;
        };
        "Scratchpad" = {
          id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          position = 3000;
          icon = "📝";
          container = 3;
        };
      };

      # Pinned Tabs
      pinsForce = true;
      pinsForceAction = "remove";

      pins = {
        # === Personal ===
        "YouTube" = {
          id = "11111111-2222-3333-4444-555555555555";
          url = "https://youtube.com";
          position = 100;
          workspace = "c6de089c-410d-4206-961d-ab11f988d40a";
        };
        "Mail" = {
          id = "22222222-3333-4444-5555-666666666666";
          url = "https://da13.domains.co.za/roundcube";
          position = 200;
          workspace = "c6de089c-410d-4206-961d-ab11f988d40a";
        };
        "GitHub" = {
          id = "33333333-4444-5555-6666-777777777777";
          url = "https://github.com";
          position = 300;
          workspace = "c6de089c-410d-4206-961d-ab11f988d40a";
        };
        "Bitwarden" = {
          id = "44444444-5555-6666-7777-888888888888";
          url = "https://vault.bitwarden.com";
          position = 400;
          workspace = "c6de089c-410d-4206-961d-ab11f988d40a";
        };
        "Twitch" = {
          id = "55555555-6666-7777-8888-999999999999";
          url = "https://twitch.tv";
          position = 500;
          workspace = "c6de089c-410d-4206-961d-ab11f988d40a";
        };

        # === Work ===
        "Claude" = {
          id = "a1b2c3d4-e5f6-7890-abcd-ef1234567890";
          url = "https://claude.ai/new";
          position = 600;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Warp Vault" = {
          id = "b2c3d4e5-f6g7-8901-hijk-lmnopqrstuvw";
          url = "https://vault.warpdevelopment.com/";
          position = 700;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Lumix Bitbucket" = {
          id = "c3d4e5f6-g7h8-9012-ijkl-mnopqrstuvwx";
          url = "https://bitbucket.org/warpdevelopment-devops/lumix";
          position = 800;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Outlook" = {
          id = "d4e5f6g7-h8i9-0123-jklm-nopqrstuvwxy";
          url = "https://outlook.office.com/mail/inbox";
          position = 900;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Jira Lumix" = {
          id = "e5f6g7h8-i9j0-1234-klmn-opqrstuvwxyz";
          url = "https://warpdevelopment.atlassian.net/jira/software/c/projects/LUM/boards/1511/backlog";
          position = 1000;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Staging Lumix" = {
          id = "f6g7h8i9-j0k1-2345-lmno-pqrstuvwxyzab";
          url = "https://staging.lumix.co/login";
          position = 1100;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "PandaDoc" = {
          id = "g7h8i9j0-k1l2-3456-mnop-qrstuvwxyzabc";
          url = "https://app.pandadoc.com/a/#/documents-next";
          position = 1200;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
        "Xero" = {
          id = "h8i9j0k1-l2m3-4567-nopq-rstuvwxyzabcd";
          url = "https://login.xero.com/identity/user/login";
          position = 1300;
          workspace = "cdd10fab-4fc5-494b-9041-325e5759195b";
        };
      };

      # Full Gruvbox Dark userChrome
      userChrome = ''
        /* Gruvbox Dark Theme for Zen Browser */
        :root {
          --zen-colors-primary: #d79921;
          --zen-colors-secondary: #b16286;
          --zen-colors-tertiary: #8ec07c;
          --zen-colors-background: #1d2021;
          --zen-colors-foreground: #ebdbb2;
          --zen-colors-border: #665c54;
          --zen-colors-tab-active: #665c54;
        }

        #navigator-toolbox,
        #TabsToolbar,
        #zen-sidebar,
        .sidebar-panel {
          background-color: #1d2021 !important;
        }

        .tab-background {
          background-color: #3c3836 !important;
        }

        .tab-background[selected="true"] {
          background-color: var(--zen-colors-tab-active) !important;
        }

        .tab-label,
        .tab-icon-image,
        .zen-workspace-icon {
          color: #ebdbb2 !important;
        }

        .tab-icon-image {
          width: 16px;
          height: 16px;
        }

        #urlbar {
          background-color: #282828 !important;
          color: #ebdbb2 !important;
          border-color: #665c54 !important;
        }

        .zen-workspace-icon,
        toolbarbutton:hover,
        .tab-background[selected="true"] .tab-icon-image {
          filter: drop-shadow(0 0 4px #d79921) !important;
        }

        .sidebar-item:hover {
          background-color: #3c3836 !important;
        }
      '';
    };
  };
}
