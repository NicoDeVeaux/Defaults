import { spawn } from "child_process"
import path from "path"
import type { Hooks, PluginInput } from "@opencode-ai/plugin"

const HOME = process.env.HOME!
const PEON_PATH = path.join(HOME, ".config/opencode/peon-ping/peon.sh")

function pipeToPeon(payload: Record<string, string>) {
  const child = spawn("bash", [PEON_PATH], {
    stdio: ["pipe", "ignore", "ignore"],
    env: { ...process.env },
    detached: true,
  })
  child.stdin.write(JSON.stringify(payload))
  child.stdin.end()
  child.unref()
}

export default async function PeonPingPlugin(input: PluginInput): Promise<Hooks> {
  const cwd = input.directory

  return {
    async event({ event }) {
      const props = event.properties as Record<string, any>
      let hookEvent: string | null = null
      let extra: Record<string, string> = {}

      switch (event.type) {
        case "session.created":
          hookEvent = "SessionStart"
          break
        case "session.status":
          if (props.status?.type === "idle")
            hookEvent = "Stop"
          break
        case "permission.asked":
          hookEvent = "Notification"
          extra = { notification_type: "permission_prompt" }
          break
      }

      if (!hookEvent) return

      pipeToPeon({
        hook_event_name: hookEvent,
        session_id: props.sessionID ?? props.info?.id ?? "",
        cwd,
        ...extra,
      })
    },

    async "chat.message"(messageInput, _output) {
      pipeToPeon({
        hook_event_name: "UserPromptSubmit",
        session_id: messageInput.sessionID ?? "",
        cwd,
      })
    },
  }
}
