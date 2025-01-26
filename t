#Python

from collections import deque

class Solution:
    def kahnsTopologicalSort(self, adj, indegree, visited, source):
        queue = deque([source])
        last_node = -1

        while queue:
            curr = queue.popleft()
            visited[curr] = True
            last_node = curr

            neighbor = adj[curr]
            indegree[neighbor] -= 1
            if indegree[neighbor] == 0 and not visited[neighbor]:
                queue.append(neighbor)
        
        return adj[last_node]

    def maxDepthBFS(self, reverse_adj, orig_visited, n, source, avoid):
        visited = [False] * n
        queue = deque([source])
        visited[source] = True
        visited[avoid] = True

        levels = 0
        while queue:
            for _ in range(len(queue)):
                curr = queue.popleft()
                orig_visited[curr] = True

                for neighbor in reverse_adj[curr]:
                    if not visited[neighbor]:
                        visited[neighbor] = True
                        queue.append(neighbor)
            levels += 1
        return levels

    def bfs(self, adj, visited, source):
        queue = deque([source])
        visited[source] = True

        count = 0
        while queue:
            curr = queue.popleft()

            if not visited[adj[curr]]:
                visited[adj[curr]] = True
                queue.append(adj[curr])
            count += 1
        return count

    def maximumInvitations(self, adj):
        n = len(adj)
        reverse_adj = [[] for _ in range(n)]
        indegree = [0] * n

        for i in range(n):
            reverse_adj[adj[i]].append(i)
            indegree[adj[i]] += 1

        total_tail_len = 0
        visited = [False] * n
        for i in range(n):
            if indegree[i] == 0 and not visited[i]:
                node = self.kahnsTopologicalSort(adj, indegree, visited, i)
                if adj[adj[node]] == node:
                    len_tail = self.maxDepthBFS(reverse_adj, visited, n, node, adj[node]) - 1
                    total_tail_len += len_tail
                    visited[node] = False

        two_size_cycles = 0
        max_cycle_size = 0
        for i in range(n):
            if not visited[i]:
                cycle_size = self.bfs(adj, visited, i)
                if cycle_size == 2:
                    two_size_cycles += 1
                else:
                    max_cycle_size = max(max_cycle_size, cycle_size)

        cycle_size_2 = total_tail_len + 2 * two_size_cycles
        return max(cycle_size_2, max_cycle_size)
