import random
import copy
import numpy as np

"""
Solving 8-puzzle using A*

Pseudocode:

open = [initial_node] ---- frontier nodes
closed = []           ---- expanded nodes

while True:

    if open is empty:
        print "there is no solution"
        exit

    current = open node with the lowest f

    if current = goal:
        print solution
        exit

    move current from open to closed

    for each children of current:

        if a copy of child is in open:
            if child is better than copy:
                update it (replace copy with child)
            else:
                do nothing

        else if a copy of child is in closed:
            if child is better than copy:
                give it another chance (delete copy from closed, add child to open)
            else:
                do nothing

        else:
            add child to open

"""

def random_state():
    flat = [0, 1, 2, 3, 4, 5, 6, 7, 8] # flat = [x for x in range(0,9)]
    random.shuffle(flat)
    state = [flat[0:3], flat[3:6], flat[6:9]]
    if is_solvable(state):
        return state
    else:
        return random_state()


def is_solvable(state): # state is a matrix of size 3x3
    flat = state[0] + state[1] + state[2] # flat is a vector of size 9
    reversed_count = 0
    for i in range(0, 8):
        for j in range(i + 1, 9):
            if flat[i] != 0 and flat[j] != 0 and flat[i] > flat[j]:
                reversed_count += 1
    return reversed_count % 2 == 0


def find_index(state, value):
    for i in range(3):
        for j in range(3):
            if state[i][j] == value:
                return (i, j)


def index_of_state(state, node_list):
    for i in range(0, len(node_list)):
        if node_list[i].get_state() == state:
            return i
    return -1


def print_path(current_node):
    # Güzel bir çıktı için numpy kullanıyoruz
    if current_node.get_parent() is None:
        print(np.array(current_node.get_state()), "\n")
    else:
        # Alttaki iki satırın yerini değiştirirsek tersten yazar
        print_path(current_node.get_parent())
        print(np.array(current_node.get_state()), "\n")

class Node:

    def __init__(self, state, parent, g):
        self.state = state
        self.parent = parent
        self.g = g

    def get_state(self):
        return self.state

    def get_parent(self):
        return self.parent

    def get_g(self):
        return self.g

    def get_h(self):
        goal_state = [[1, 2, 3], [4, 5, 6], [7, 8, 0]]
        h = 0
        for value in range(1, 9):
            i, j = find_index(self.state, value)
            goal_i, goal_j = find_index(goal_state, value)
            h += abs(i - goal_i) + abs(goal_j - j)
        return h

    def get_f(self):
        return self.get_g() + self.get_h()

    def get_children(self):
        children = []
        x, y = find_index(self.state, 0)
        l = [[0, 1], [0, -1], [1, 0], [-1, 0]]
        for i, j in l:
            if 0 <= x + i <= 2 and 0 <= y + j <= 2:
                child_state = copy.deepcopy(self.state)
                child_state[x][y] = child_state[x + i][y + j]
                child_state[x + i][y + j] = 0
                child = Node(child_state, self, self.get_g() + 1)
                children.append(child)
        return children


initial_node = Node(random_state(), None, 0)
#initial_node = Node([[1, 2, 3], [4, 5, 6], [7, 8, 0]], None, 0) # Başlangıç durumu keyfi olarak girilecekse

open_list = [initial_node]
closed_list = []

while True:

    if len(open_list) == 0:
        print("There is no solution.")
        break

    best_index = 0
    for i in range(1, len(open_list)):
        if open_list[i].get_f() < open_list[best_index].get_f():
            best_index = i
    best_node = open_list[best_index]

    if best_node.get_h() == 0: # çözüm bulundu
        print("Number of steps:", best_node.get_g())
        print_path(best_node)
        break

    del open_list[best_index]
    closed_list.append(best_node)

    children = best_node.get_children()
    for child in children:

        index_open = index_of_state(child.get_state(), open_list)
        index_closed = index_of_state(child.get_state(), closed_list)

        if index_open >= 0: # ön saflarımızda zaten var, eğer bu daha kısa bir yolsa eskisini güncelleyelim
            if child.get_g() < open_list[index_open].get_g():
                open_list[index_open] = child

        elif index_closed >= 0: # önceden incelemişiz, eğer bu daha kısa bir yolsa ön saflara ekleyip tekrar şans verelim
            if child.get_g() < closed_list[index_closed].get_g():
                del closed_list[index_closed]
                open_list.append(child)

        else: # yeni bir state: ön saflara ekleyelim
            open_list.append(child)

