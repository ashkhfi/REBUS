<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\Pakaian;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\JsonResponse;


class PakaianController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'nama' => 'required',
            'deskripsi' => 'required',
            'kategori' => 'required',
            'kelamin' => 'required',
            'usia' => 'required',
            'status' => 'required',
            'harga' => 'required|numeric',
            'image' => 'required|image|max:2048',
        ]);

        $imageName = time() . '.' . $request->image->extension();
        $request->image->storeAs('public/images', $imageName);

        $pakaian = Pakaian::create([
            'nama' => $request->nama,
            'image' => $imageName,
            'deskripsi' => $request->deskripsi,
            'kategori' => $request->kategori,
            'kelamin' => $request->kelamin,
            'usia' => $request->usia,
            'status' => $request->status,
            'harga' => $request->harga,
        ]);

        return response()->json($pakaian, 201);
    }

    public function updateStatus(Request $request, $id): JsonResponse
    {
        $request->validate([
            'status' => 'required',
        ]);

        $pakaian = Pakaian::findOrFail($id);
        $pakaian->status = $request->status;
        $pakaian->save();

        return response()->json($pakaian, 200);
    }

    public function delete($id): JsonResponse
    {
        $pakaian = Pakaian::findOrFail($id);

        // Hapus gambar jika ada
        if ($pakaian->image) {
            Storage::delete('public/storage/pakaian' . $pakaian->image);
        }

        $pakaian->delete();

        return response()->json(['message' => 'Pakaian deleted successfully'], 200);
    }

    public function index(): JsonResponse
    {
        $pakaian = Pakaian::all();

        return response()->json($pakaian, 200);
    }
    public function show($id): JsonResponse
{
    $pakaian = Pakaian::findOrFail($id);

    return response()->json($pakaian, 200);
}


public function update(Request $request, $id): JsonResponse
{
    $pakaian = Pakaian::findOrFail($id);
    $request->validate([
        'nama' => 'required',
        'deskripsi' => 'required',
        'kategori' => 'required',
        'kelamin' => 'required',
        'usia' => 'required',
        'status' => 'required',
        'harga' => 'required|numeric',
        'image' => 'required|image|max:2048',
    ]);

    $imageName = time() . '.' . $request->image->extension();
    $request->image->storeAs('public/images', $imageName);

    $pakaian->nama = $request->nama;
    $pakaian->deskripsi = $request->deskripsi;
    $pakaian->kelamin = $request->kelamin;
    $pakaian->kategori = $request->kategori;
    $pakaian->usia = $request->usia;
    $pakaian->harga = $request->harga;
    $pakaian->image = $request->image;
    $pakaian->status = $request->status;


    return response()->json($pakaian, 200);
}
}
