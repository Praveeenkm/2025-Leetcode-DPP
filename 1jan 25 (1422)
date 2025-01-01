2025-Leetcode-DPP
#python
class Solution {
public:
    int maxScore(string s) {
        int n=s.size();
        int one_count=0;
        for(int i=0;i<n;i++)
        if(s[i]=='1')
        one_count++;
        int zero_count=0;
        int max_score=0;
        for(int i=0;i<n-1;i++){
            if(s[i]=='1') one_count--;
            else zero_count++;
            max_score=max(max_score,zero_count+one_count);
        }
        return max_score;
    }
};
        

