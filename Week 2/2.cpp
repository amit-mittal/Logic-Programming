#include <iostream>
#include <cstdio>
#include <set>
#include <string>
#include <algorithm>

using namespace std;

typedef set< set<string> > ss;
typedef set<string> sstr;

// Prints one clause
void printClause(sstr clause){	
	sstr::iterator it;
	for(it = clause.begin() ; it != clause.end() ; ++it){
		cout << (*it) << " ";
	}
	cout << endl;
}

// Prints a set containing multiple clauses
void printSet(ss clause_set){	
	ss::iterator it;
	for(it = clause_set.begin() ; it != clause_set.end() ; ++it){
		printClause(*it);
	}
}

// Checks if union of 2 clauses is reqd
bool check_if_take_union(sstr a, sstr b){
	sstr::iterator a_it;

	for(a_it = a.begin();a_it != a.end(); ++a_it){
		string f = *a_it;

		// checks for p and !p in diff clauses
		if(f[0] == '!'){
			if(find(b.begin(), b.end(), f.substr(1)) != b.end()) {
				return true;
			}
		} else {
			if(find(b.begin(), b.end(), "!" + f) != b.end()) {
				return true;
			}
		}
	}

	return false;
}

// Takes resolution of 2 clauses and returns new clause
sstr take_union(sstr a, sstr b){
	sstr result;
	sstr::iterator a_it, b_it;
	bool taken = false;// keeps track if p & !p are found

	for(a_it = a.begin();a_it != a.end(); ++a_it){
		string f = *a_it;
		
		if(!taken){
			if(f[0] == '!'){
				if(find(b.begin(), b.end(), f.substr(1)) != b.end()){
					b.erase(find(b.begin(), b.end(), f.substr(1)));
					taken = true;
				} else {
					result.insert(f);
				}
			} else {
				if(find(b.begin(), b.end(), "!" + f) != b.end()){
					b.erase(find(b.begin(), b.end(), "!" + f));
					taken = true;
				} else {
					result.insert(f);
				}
			}
		} else {
			result.insert(f);
		}
	}

	for(b_it = b.begin();b_it != b.end(); ++b_it){
		result.insert(*b_it);
	}

	return result;
}

// Checks if the set of clauses is satisfiable or not
bool ifSatisfiable(ss a){
	while(1){
		ss newClauseSet;
		ss::iterator it;

		for(it = a.begin();it != a.end();++it){
			ss::iterator jt;

			for(jt = it;jt != a.end();++jt){
				sstr newSet;

				if(it != jt){
					if(check_if_take_union(*it, *jt)){
						newSet = take_union(*it, *jt);
						if(newSet.size() == 0)
							return false;
						newClauseSet.insert(newSet);
					}
				}
			}
		}

		int oldSize = a.size();
		a.insert(newClauseSet.begin(), newClauseSet.end());	

		if(oldSize == (int)a.size())
			break;
	}
	
	return true;
}

int main(){
	int n;
	ss clause_set;
		
	scanf("%d", &n);
	for(int i=0;i<n;++i){
		set<string> clause;
		while(1){
			string s;
			cin >> s;
			
			if(s[s.size() - 1] == '.'){
				clause.insert(s.substr(0, s.size()-1));
				break;
			}
			
			clause.insert(s);
		}
		clause_set.insert(clause);
	}
	
	cout << "Enter: ";
	set<string> formula;
	while(1){
		string s;
		cin >> s;
		
		if(s[s.size() - 1] == '.'){
			if(s[0] == '!'){
				formula.insert(s.substr(1, s.size()-2));
			} else {
				formula.insert("!" + s.substr(0, s.size()-1));
			}	
			break;
		}

		if(s[0] == '!'){
			formula.insert(s.substr(1, s.size()-1));
		} else {
			formula.insert("!" + s.substr(0, s.size()-1));
		}
	}
	
	ss new_set(clause_set);
	new_set.insert(formula);

	cout << "Printing set whose unsatisfiability we will check:\n";	
	printSet(new_set);
	
	if(ifSatisfiable(new_set)){
		cout << "NO\n";		
	} else {
		cout << "YES\n";
	}
	
	return 0;
}